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
  [ "$total" -gt 0 ] && pct=$(( score * 100 / total ))
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
# Question 3 | ServiceAccount, Role, and RoleBinding (5 points)
# ============================================================================
score=0
total=5
print_header "Question 3 | ServiceAccount, Role, and RoleBinding"

check_criterion "ServiceAccount log-sa exists in q03" \
  "$(resource_exists sa/log-sa q03)" && ((score++))

check_criterion "Role log-role exists in q03" \
  "$(resource_exists role/log-role q03)" && ((score++))

verbs=$(kubectl get role log-role -n q03 -o jsonpath='{.rules[0].verbs[*]}' 2>/dev/null)
has_verbs=false
echo "$verbs" | grep -q "get" && echo "$verbs" | grep -q "list" && echo "$verbs" | grep -q "watch" && has_verbs=true
check_criterion "Role log-role grants get, list, watch on pods" "$has_verbs" && ((score++))

check_criterion "RoleBinding log-rb exists in q03" \
  "$(resource_exists rolebinding/log-rb q03)" && ((score++))

pod_sa=$(kget pod/log-collector q03 '.spec.serviceAccountName')
check_criterion "Pod log-collector uses ServiceAccount log-sa" \
  "$([ "$pod_sa" = "log-sa" ] && echo true || echo false)" && ((score++))

print_score $score $total
