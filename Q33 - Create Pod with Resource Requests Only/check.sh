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
# Q33 CHECKS
# ============================================================================
score=0
total=3

print_header "Q33 - Create Pod with Resource Requests Only"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/request-pod" "q33")
check_criterion "Pod 'request-pod' exists in namespace q33" "$pod_exists" && ((score++)) || true

# Check 2: CPU request is 250m
cpu_request=$(kget "pod/request-pod" "q33" ".spec.containers[0].resources.requests.cpu")
correct_cpu="false"
[ "$cpu_request" = "250m" ] && correct_cpu="true"
check_criterion "CPU request is 250m" "$correct_cpu" && ((score++)) || true

# Check 3: Memory request is 128Mi
mem_request=$(kget "pod/request-pod" "q33" ".spec.containers[0].resources.requests.memory")
correct_mem="false"
[ "$mem_request" = "128Mi" ] && correct_mem="true"
check_criterion "Memory request is 128Mi" "$correct_mem" && ((score++)) || true

print_score $score $total
