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
# Q44 CHECKS
# ============================================================================
score=0
total=2

print_header "Q44 - Rolling Restart Deployment"

# Check 1: Deployment exists
exists=$(resource_exists "deployment/restart-app" "q40")
check_criterion "Deployment 'restart-app' exists in namespace q40" "$exists" && ((score++)) || true

# Check 2: Rollout history has at least 2 revisions (indicating restart happened)
rev_count=$(kubectl rollout history deployment/restart-app -n q40 2>/dev/null | grep -c "^[0-9]" || echo "0")
rev_ok="false"
[ "$rev_count" -gt 1 ] && rev_ok="true"
check_criterion "Rollout history has at least 2 revisions (count: $rev_count)" "$rev_ok" && ((score++)) || true

print_score $score $total
