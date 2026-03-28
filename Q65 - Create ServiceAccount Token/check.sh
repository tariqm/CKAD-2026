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
# Q76 CHECKS
# ============================================================================
score=0
total=3

print_header "Q76 - Create ServiceAccount Token"

# Check 1: ServiceAccount exists
SA_EXISTS=$(resource_exists "serviceaccount/api-service-account" "q65")
check_criterion "ServiceAccount 'api-service-account' exists in namespace q65" "$SA_EXISTS" && ((score++)) || true

# Check 2: Token file exists
TOKEN_FILE_EXISTS="false"
[ -f /tmp/sa-token.txt ] && TOKEN_FILE_EXISTS="true"
check_criterion "Token file '/tmp/sa-token.txt' exists" "$TOKEN_FILE_EXISTS" && ((score++)) || true

# Check 3: Token file is not empty and contains a valid JWT-like string
TOKEN_VALID="false"
if [ -f /tmp/sa-token.txt ]; then
  TOKEN=$(cat /tmp/sa-token.txt)
  # JWT tokens have 3 base64 segments separated by dots
  if echo "$TOKEN" | grep -qE '^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$'; then
    TOKEN_VALID="true"
  fi
fi
check_criterion "Token file contains a valid JWT token" "$TOKEN_VALID" && ((score++)) || true

print_score $score $total
