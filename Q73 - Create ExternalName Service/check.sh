#!/bin/bash
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
# Q73 - Create ExternalName Service
# ============================================================================
score=0
total=3

print_header "Q73 - Create ExternalName Service"

# Check 1: Service exists
EXISTS=$(resource_exists "svc/external-db" "q73")
check_criterion "Service 'external-db' exists in namespace q73" "$EXISTS" && ((score++)) || true

# Check 2: Service type is ExternalName
SVC_TYPE=$(kget "svc/external-db" "q73" ".spec.type")
IS_EXTERNAL="false"
[ "$SVC_TYPE" = "ExternalName" ] && IS_EXTERNAL="true"
check_criterion "Service type is ExternalName" "$IS_EXTERNAL" && ((score++)) || true

# Check 3: ExternalName points to correct DNS
EXT_NAME=$(kget "svc/external-db" "q73" ".spec.externalName")
HAS_EXT_NAME="false"
[ "$EXT_NAME" = "db.example.com" ] && HAS_EXT_NAME="true"
check_criterion "ExternalName is 'db.example.com'" "$HAS_EXT_NAME" && ((score++)) || true

print_score $score $total
