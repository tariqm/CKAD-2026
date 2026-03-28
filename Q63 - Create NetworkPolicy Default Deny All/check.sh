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
# Q74 CHECKS
# ============================================================================
score=0
total=4

print_header "Q74 - Create NetworkPolicy Default Deny All"

# Check 1: NetworkPolicy exists
NP_EXISTS=$(resource_exists "networkpolicy/deny-all-ingress" "q63")
check_criterion "NetworkPolicy 'deny-all-ingress' exists in namespace q63" "$NP_EXISTS" && ((score++)) || true

# Check 2: podSelector is empty (selects all pods)
POD_SELECTOR=$(kget "networkpolicy/deny-all-ingress" "q63" ".spec.podSelector")
EMPTY_SELECTOR="false"
[ "$POD_SELECTOR" = "{}" ] || [ -z "$POD_SELECTOR" ] && EMPTY_SELECTOR="true"
# Also check via matchLabels being absent
ML=$(kget "networkpolicy/deny-all-ingress" "q63" ".spec.podSelector.matchLabels")
[ -z "$ML" ] && EMPTY_SELECTOR="true"
check_criterion "podSelector selects all pods (empty selector)" "$EMPTY_SELECTOR" && ((score++)) || true

# Check 3: policyTypes includes Ingress
POLICY_TYPES=$(kget "networkpolicy/deny-all-ingress" "q63" ".spec.policyTypes[*]")
HAS_INGRESS="false"
echo "$POLICY_TYPES" | grep -q "Ingress" && HAS_INGRESS="true"
check_criterion "policyTypes includes 'Ingress'" "$HAS_INGRESS" && ((score++)) || true

# Check 4: No ingress rules defined (deny all)
INGRESS_RULES=$(kget "networkpolicy/deny-all-ingress" "q63" ".spec.ingress")
NO_RULES="false"
[ -z "$INGRESS_RULES" ] && NO_RULES="true"
check_criterion "No ingress rules defined (deny all)" "$NO_RULES" && ((score++)) || true

print_score $score $total
