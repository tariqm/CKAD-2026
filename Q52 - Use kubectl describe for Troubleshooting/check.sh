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
# Q52 CHECKS
# ============================================================================
score=0
total=3

print_header "Q52 - Use kubectl describe for Troubleshooting"

# Check 1: service exists
EXISTS=$(resource_exists "service/troubleshoot-svc" "q52")
check_criterion "Service 'troubleshoot-svc' exists in namespace q52" "$EXISTS" && ((score++)) || true

# Check 2: selector is app=troubleshoot-app
SELECTOR=$(kget "service/troubleshoot-svc" "q52" ".spec.selector.app")
if [ "$SELECTOR" = "troubleshoot-app" ]; then
  SELECTOR_OK="true"
else
  SELECTOR_OK="false"
fi
check_criterion "Service selector is app=troubleshoot-app (got: ${SELECTOR:-none})" "$SELECTOR_OK" && ((score++)) || true

# Check 3: service has endpoints
ENDPOINTS=$(kubectl get endpoints troubleshoot-svc -n q52 -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
if [ -n "$ENDPOINTS" ]; then
  HAS_ENDPOINTS="true"
else
  HAS_ENDPOINTS="false"
fi
check_criterion "Service has active endpoints" "$HAS_ENDPOINTS" && ((score++)) || true

print_score $score $total
