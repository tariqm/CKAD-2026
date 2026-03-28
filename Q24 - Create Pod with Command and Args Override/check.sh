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
# Q24 CHECKS
# ============================================================================
score=0
total=3

print_header "Q24 - Create Pod with Command and Args Override"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/custom-cmd-pod" "q24")
check_criterion "Pod 'custom-cmd-pod' exists in namespace q24" "$pod_exists" && ((score++)) || true

# Check 2: Pod is Running
pod_phase=$(kget "pod/custom-cmd-pod" "q24" ".status.phase")
is_running=$( [ "$pod_phase" = "Running" ] && echo true || echo false )
check_criterion "Pod is in Running state" "$is_running" && ((score++)) || true

# Check 3: Container command contains "sh"
cmd=$(kget "pod/custom-cmd-pod" "q24" ".spec.containers[0].command[*]")
has_sh=$( echo "$cmd" | grep -q "sh" && echo true || echo false )
check_criterion "Container command contains 'sh'" "$has_sh" && ((score++)) || true

print_score $score $total
