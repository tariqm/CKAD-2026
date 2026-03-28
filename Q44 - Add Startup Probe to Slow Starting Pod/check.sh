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
# Q48 CHECKS
# ============================================================================
score=0
total=4

print_header "Q48 - Add Startup Probe to Slow Starting Pod"

# Check 1: Pod exists
exists=$(resource_exists "pod/slow-start-pod" "q44")
check_criterion "Pod 'slow-start-pod' exists in namespace q44" "$exists" && ((score++)) || true

# Check 2: Has startup probe
startup=$(kget "pod/slow-start-pod" "q44" ".spec.containers[0].startupProbe")
startup_ok="false"
[ -n "$startup" ] && startup_ok="true"
check_criterion "Pod has a startup probe configured" "$startup_ok" && ((score++)) || true

# Check 3: failureThreshold is 30
failure_threshold=$(kget "pod/slow-start-pod" "q44" ".spec.containers[0].startupProbe.failureThreshold")
ft_ok="false"
[ "$failure_threshold" = "30" ] && ft_ok="true"
check_criterion "failureThreshold is 30 (got: $failure_threshold)" "$ft_ok" && ((score++)) || true

# Check 4: periodSeconds is 10
period=$(kget "pod/slow-start-pod" "q44" ".spec.containers[0].startupProbe.periodSeconds")
period_ok="false"
[ "$period" = "10" ] && period_ok="true"
check_criterion "periodSeconds is 10 (got: $period)" "$period_ok" && ((score++)) || true

print_score $score $total
