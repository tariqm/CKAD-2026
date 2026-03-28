#!/bin/bash
# ============================================================================
# SCORING FUNCTIONS
# ============================================================================
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_success() { echo -e "  ${GREEN}PASS${NC} - $1"; }
print_fail() { echo -e "  ${RED}FAIL${NC} - $1"; }

print_header() {
  echo ""
  echo -e "${CYAN}========================================================${NC}"
  echo -e "${BOLD}$1${NC}"
  echo -e "${CYAN}========================================================${NC}"
}

print_score() {
  local score=$1 total=$2 pct=0
  [ "$total" -gt 0 ] && pct=$((score * 100 / total))
  if [ "$score" -eq "$total" ]; then
    echo -e "\n  ${GREEN}${BOLD}Score: $score/$total ($pct%)${NC}\n"
  elif [ "$score" -gt 0 ]; then
    echo -e "\n  ${YELLOW}${BOLD}Score: $score/$total ($pct%)${NC}\n"
  else
    echo -e "\n  ${RED}${BOLD}Score: $score/$total ($pct%)${NC}\n"
  fi
}

check_criterion() {
  local description="$1" condition="$2"
  if [ "$condition" = "true" ]; then
    print_success "$description"; return 0
  else
    print_fail "$description"; return 1
  fi
}

resource_exists() { kubectl get "$1" -n "$2" >/dev/null 2>&1 && echo true || echo false; }
kget() { kubectl get "$1" -n "$2" -o jsonpath="{$3}" 2>/dev/null; }

# ============================================================================
# Q32 CHECKS
# ============================================================================
score=0
total=3

print_header "Q32 - Create Temporary Debug Pod"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/debug-pod" "q32")
check_criterion "Pod 'debug-pod' exists in namespace q32" "$pod_exists" && ((score++)) || true

# Check 2: restartPolicy is Never
restart_policy=$(kget "pod/debug-pod" "q32" ".spec.restartPolicy")
correct_restart="false"
[ "$restart_policy" = "Never" ] && correct_restart="true"
check_criterion "Pod restartPolicy is Never" "$correct_restart" && ((score++)) || true

# Check 3: Image is busybox
image=$(kget "pod/debug-pod" "q32" ".spec.containers[0].image")
correct_image="false"
echo "$image" | grep -q "busybox" && correct_image="true"
check_criterion "Pod image is busybox" "$correct_image" && ((score++)) || true

print_score $score $total
