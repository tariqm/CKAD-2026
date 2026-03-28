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
# Q36 CHECKS
# ============================================================================
score=0
total=4

print_header "Q36 - Blue-Green Deployment Switch"

# Check 1: Service exists
SVC_EXISTS=$(resource_exists "svc/app-svc" "q36")
check_criterion "Service 'app-svc' exists in namespace q36" "$SVC_EXISTS" && ((score++)) || true

# Check 2: Blue deployment still exists
BLUE_EXISTS=$(resource_exists "deployment/app-blue" "q36")
check_criterion "Deployment 'app-blue' still exists" "$BLUE_EXISTS" && ((score++)) || true

# Check 3: Green deployment still exists
GREEN_EXISTS=$(resource_exists "deployment/app-green" "q36")
check_criterion "Deployment 'app-green' still exists" "$GREEN_EXISTS" && ((score++)) || true

# Check 4: Service selector points to green
VERSION_SELECTOR=$(kget "svc/app-svc" "q36" ".spec.selector.version")
POINTS_TO_GREEN="false"
[ "$VERSION_SELECTOR" = "green" ] && POINTS_TO_GREEN="true"
check_criterion "Service selector points to version 'green'" "$POINTS_TO_GREEN" && ((score++)) || true

print_score $score $total
