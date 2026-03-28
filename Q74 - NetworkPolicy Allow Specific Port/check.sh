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
# Q85 - NetworkPolicy Allow Specific Port
# ============================================================================
score=0
total=4

print_header "Q85 - NetworkPolicy Allow Specific Port"

# Check 1: NetworkPolicy exists
EXISTS=$(resource_exists "networkpolicy/allow-port-80" "q74")
check_criterion "NetworkPolicy 'allow-port-80' exists in namespace q74" "$EXISTS" && ((score++)) || true

# Check 2: Policy applies to pods with app=web
POD_SELECTOR=$(kget "networkpolicy/allow-port-80" "q74" ".spec.podSelector.matchLabels.app")
HAS_SELECTOR="false"
[ "$POD_SELECTOR" = "web" ] && HAS_SELECTOR="true"
check_criterion "Policy applies to pods with app=web" "$HAS_SELECTOR" && ((score++)) || true

# Check 3: Policy type includes Ingress
POLICY_TYPES=$(kget "networkpolicy/allow-port-80" "q74" ".spec.policyTypes")
HAS_INGRESS="false"
echo "$POLICY_TYPES" | grep -q "Ingress" && HAS_INGRESS="true"
check_criterion "Policy type includes Ingress" "$HAS_INGRESS" && ((score++)) || true

# Check 4: Ingress rule allows port 80
INGRESS_PORT=$(kget "networkpolicy/allow-port-80" "q74" ".spec.ingress[0].ports[0].port")
HAS_PORT="false"
[ "$INGRESS_PORT" = "80" ] && HAS_PORT="true"
check_criterion "Ingress rule allows port 80" "$HAS_PORT" && ((score++)) || true

print_score $score $total
