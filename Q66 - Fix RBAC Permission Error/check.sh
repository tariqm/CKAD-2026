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
# Q66 - Fix RBAC Permission Error
# ============================================================================
score=0
total=3

print_header "Q66 - Fix RBAC Permission Error"

# Check 1: Role exists
EXISTS=$(resource_exists "role/deploy-role" "q66")
check_criterion "Role 'deploy-role' exists in namespace q66" "$EXISTS" && ((score++)) || true

# Check 2: Role includes deployments resource
ROLE_JSON=$(kubectl get role deploy-role -n q66 -o json 2>/dev/null)
HAS_DEPLOYMENTS="false"
if echo "$ROLE_JSON" | grep -q '"deployments"'; then
  APPS_GROUP=$(echo "$ROLE_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data.get('rules', []):
    if 'deployments' in rule.get('resources', []):
        if 'apps' in rule.get('apiGroups', []):
            print('true')
            sys.exit(0)
print('false')
" 2>/dev/null)
  [ "$APPS_GROUP" = "true" ] && HAS_DEPLOYMENTS="true"
fi
check_criterion "Role includes 'deployments' resource with 'apps' apiGroup" "$HAS_DEPLOYMENTS" && ((score++)) || true

# Check 3: Role includes create verb for deployments
HAS_CREATE="false"
if [ "$ROLE_JSON" != "" ]; then
  HAS_CREATE=$(echo "$ROLE_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data.get('rules', []):
    if 'deployments' in rule.get('resources', []):
        if 'create' in rule.get('verbs', []):
            print('true')
            sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Role includes 'create' verb for deployments" "$HAS_CREATE" && ((score++)) || true

print_score $score $total
