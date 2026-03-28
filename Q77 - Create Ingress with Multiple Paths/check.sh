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
# Q77 - Create Ingress with Multiple Paths
# ============================================================================
score=0
total=5

print_header "Q77 - Create Ingress with Multiple Paths"

# Check 1: Ingress exists
EXISTS=$(resource_exists "ingress/multi-path-ingress" "q77")
check_criterion "Ingress 'multi-path-ingress' exists in namespace q77" "$EXISTS" && ((score++)) || true

# Check 2: Host is app.example.com
HOST=$(kget "ingress/multi-path-ingress" "q77" ".spec.rules[0].host")
HAS_HOST="false"
[ "$HOST" = "app.example.com" ] && HAS_HOST="true"
check_criterion "Ingress host is app.example.com" "$HAS_HOST" && ((score++)) || true

# Check 3: /frontend path routes to frontend-svc
INGRESS_JSON=$(kubectl get ingress multi-path-ingress -n q77 -o json 2>/dev/null)
HAS_FRONTEND_PATH="false"
if [ -n "$INGRESS_JSON" ]; then
  HAS_FRONTEND_PATH=$(echo "$INGRESS_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data['spec'].get('rules', []):
    for path in rule.get('http', {}).get('paths', []):
        if path.get('path') in ['/frontend', '/frontend/'] and path.get('backend', {}).get('service', {}).get('name') == 'frontend-svc':
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "/frontend path routes to frontend-svc" "$HAS_FRONTEND_PATH" && ((score++)) || true

# Check 4: /api path routes to api-svc
HAS_API_PATH="false"
if [ -n "$INGRESS_JSON" ]; then
  HAS_API_PATH=$(echo "$INGRESS_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data['spec'].get('rules', []):
    for path in rule.get('http', {}).get('paths', []):
        if path.get('path') in ['/api', '/api/'] and path.get('backend', {}).get('service', {}).get('name') == 'api-svc':
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "/api path routes to api-svc" "$HAS_API_PATH" && ((score++)) || true

# Check 5: pathType is Prefix
HAS_PREFIX="false"
if [ -n "$INGRESS_JSON" ]; then
  HAS_PREFIX=$(echo "$INGRESS_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data['spec'].get('rules', []):
    for path in rule.get('http', {}).get('paths', []):
        if path.get('pathType') == 'Prefix':
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "pathType is Prefix" "$HAS_PREFIX" && ((score++)) || true

print_score $score $total
