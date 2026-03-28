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
# Q76 - NetworkPolicy Egress Rules
# ============================================================================
score=0
total=5

print_header "Q76 - NetworkPolicy Egress Rules"

# Check 1: NetworkPolicy exists
EXISTS=$(resource_exists "networkpolicy/restrict-egress" "q76")
check_criterion "NetworkPolicy 'restrict-egress' exists in namespace q76" "$EXISTS" && ((score++)) || true

# Check 2: Policy applies to pods with app=secure-app
POD_SELECTOR=$(kget "networkpolicy/restrict-egress" "q76" ".spec.podSelector.matchLabels.app")
HAS_SELECTOR="false"
[ "$POD_SELECTOR" = "secure-app" ] && HAS_SELECTOR="true"
check_criterion "Policy applies to pods with app=secure-app" "$HAS_SELECTOR" && ((score++)) || true

# Check 3: Policy type includes Egress
POLICY_TYPES=$(kget "networkpolicy/restrict-egress" "q76" ".spec.policyTypes")
HAS_EGRESS="false"
echo "$POLICY_TYPES" | grep -q "Egress" && HAS_EGRESS="true"
check_criterion "Policy type includes Egress" "$HAS_EGRESS" && ((score++)) || true

# Check 4: Egress allows DNS (port 53)
NP_JSON=$(kubectl get networkpolicy restrict-egress -n q76 -o json 2>/dev/null)
HAS_DNS="false"
if [ -n "$NP_JSON" ]; then
  HAS_DNS=$(echo "$NP_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data['spec'].get('egress', []):
    for port in rule.get('ports', []):
        if port.get('port') == 53:
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Egress allows DNS on port 53" "$HAS_DNS" && ((score++)) || true

# Check 5: Egress allows port 443
HAS_443="false"
if [ -n "$NP_JSON" ]; then
  HAS_443=$(echo "$NP_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for rule in data['spec'].get('egress', []):
    for port in rule.get('ports', []):
        if port.get('port') == 443:
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Egress allows port 443" "$HAS_443" && ((score++)) || true

print_score $score $total
