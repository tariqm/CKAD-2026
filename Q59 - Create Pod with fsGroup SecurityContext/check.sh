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
# Q70 CHECKS
# ============================================================================
score=0
total=3

print_header "Q70 - Create Pod with fsGroup SecurityContext"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/fsgroup-pod" "q59")
check_criterion "Pod 'fsgroup-pod' exists in namespace q59" "$pod_exists" && ((score++)) || true

# Check 2: fsGroup is 2000
fs_group=$(kget "pod/fsgroup-pod" "q59" ".spec.securityContext.fsGroup")
is_fsgroup=$( [ "$fs_group" = "2000" ] && echo true || echo false )
check_criterion "Pod securityContext fsGroup is 2000" "$is_fsgroup" && ((score++)) || true

# Check 3: runAsUser is 1000
run_as_user=$(kget "pod/fsgroup-pod" "q59" ".spec.securityContext.runAsUser")
is_user=$( [ "$run_as_user" = "1000" ] && echo true || echo false )
check_criterion "Pod securityContext runAsUser is 1000" "$is_user" && ((score++)) || true

print_score $score $total
