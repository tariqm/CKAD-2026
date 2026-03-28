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
# Q70 - Create ClusterIP Service
# ============================================================================
score=0
total=4

print_header "Q70 - Create ClusterIP Service"

# Check 1: Service exists
EXISTS=$(resource_exists "svc/web-svc" "q70")
check_criterion "Service 'web-svc' exists in namespace q70" "$EXISTS" && ((score++)) || true

# Check 2: Service type is ClusterIP
SVC_TYPE=$(kget "svc/web-svc" "q70" ".spec.type")
IS_CLUSTER_IP="false"
[ "$SVC_TYPE" = "ClusterIP" ] && IS_CLUSTER_IP="true"
check_criterion "Service type is ClusterIP" "$IS_CLUSTER_IP" && ((score++)) || true

# Check 3: Service selector matches deployment
SELECTOR=$(kget "svc/web-svc" "q70" ".spec.selector.app")
HAS_SELECTOR="false"
[ "$SELECTOR" = "web" ] && HAS_SELECTOR="true"
check_criterion "Service selector matches app=web" "$HAS_SELECTOR" && ((score++)) || true

# Check 4: Service port is 80
SVC_PORT=$(kget "svc/web-svc" "q70" ".spec.ports[0].port")
HAS_PORT="false"
[ "$SVC_PORT" = "80" ] && HAS_PORT="true"
check_criterion "Service port is 80" "$HAS_PORT" && ((score++)) || true

print_score $score $total
