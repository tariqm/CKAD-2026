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
# Question 9 | Rolling Update and Rollback (3 points)
# NOTE: This checks the FINAL state after rollback (nginx:1.20)
# ============================================================================
score=0
total=3
print_header "Question 9 | Rolling Update and Rollback"

check_criterion "Deployment app-v1 exists in q09" \
  "$(resource_exists deploy/app-v1 q09)" && ((score++))

image=$(kget deploy/app-v1 q09 '.spec.template.spec.containers[0].image')
check_criterion "Image is nginx:1.20 (rollback successful)" \
  "$([ "$image" = "nginx:1.20" ] && echo true || echo false)" && ((score++))

rev_count=$(kubectl rollout history deploy app-v1 -n q09 2>/dev/null | grep -c "^[0-9]")
check_criterion "Rollout history shows multiple revisions" \
  "$([ "$rev_count" -gt 1 ] 2>/dev/null && echo true || echo false)" && ((score++))

print_score $score $total
