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
# Q55 CHECKS
# ============================================================================
score=0
total=3

print_header "Q55 - Create ServiceAccount and Bind to Role"

# Check 1: ServiceAccount exists
sa_exists=$(resource_exists "serviceaccount/app-sa" "q55")
check_criterion "ServiceAccount 'app-sa' exists in namespace q55" "$sa_exists" && ((score++)) || true

# Check 2: Role exists
role_exists=$(resource_exists "role/pod-reader" "q55")
check_criterion "Role 'pod-reader' exists in namespace q55" "$role_exists" && ((score++)) || true

# Check 3: RoleBinding exists
rb_exists=$(resource_exists "rolebinding/app-sa-binding" "q55")
check_criterion "RoleBinding 'app-sa-binding' exists in namespace q55" "$rb_exists" && ((score++)) || true

print_score $score $total
