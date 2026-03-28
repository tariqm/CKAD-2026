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
# Question 1 | Create Secret from Hardcoded Variables (4 points)
# ============================================================================
score=0
total=4
print_header "Question 1 | Create Secret from Hardcoded Variables"

# 1. Secret db-credentials exists
check_criterion "Secret db-credentials exists in q01" \
  "$(resource_exists secret/db-credentials q01)" && ((score++))

# 2. Secret has correct DB_USER key
secret_user=$(kubectl get secret db-credentials -n q01 -o jsonpath='{.data.DB_USER}' 2>/dev/null | base64 -d 2>/dev/null)
check_criterion "Secret DB_USER = admin" \
  "$([ "$secret_user" = "admin" ] && echo true || echo false)" && ((score++))

# 3. Secret has correct DB_PASS key
secret_pass=$(kubectl get secret db-credentials -n q01 -o jsonpath='{.data.DB_PASS}' 2>/dev/null | base64 -d 2>/dev/null)
check_criterion "Secret DB_PASS = Secret123!" \
  "$([ "$secret_pass" = 'Secret123!' ] && echo true || echo false)" && ((score++))

# 4. Deployment uses secretKeyRef for DB_USER
env_ref=$(kubectl get deploy api-server -n q01 -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="DB_USER")].valueFrom.secretKeyRef.name}' 2>/dev/null)
check_criterion "Deployment api-server uses secretKeyRef for DB_USER" \
  "$([ "$env_ref" = "db-credentials" ] && echo true || echo false)" && ((score++))

print_score $score $total
