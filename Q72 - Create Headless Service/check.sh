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
# Q72 - Create Headless Service
# ============================================================================
score=0
total=4

print_header "Q72 - Create Headless Service"

# Check 1: Service exists
EXISTS=$(resource_exists "svc/db-headless" "q72")
check_criterion "Service 'db-headless' exists in namespace q72" "$EXISTS" && ((score++)) || true

# Check 2: ClusterIP is None (headless)
CLUSTER_IP=$(kget "svc/db-headless" "q72" ".spec.clusterIP")
IS_HEADLESS="false"
[ "$CLUSTER_IP" = "None" ] && IS_HEADLESS="true"
check_criterion "Service clusterIP is None (headless)" "$IS_HEADLESS" && ((score++)) || true

# Check 3: Service selector matches app=db
SELECTOR=$(kget "svc/db-headless" "q72" ".spec.selector.app")
HAS_SELECTOR="false"
[ "$SELECTOR" = "db" ] && HAS_SELECTOR="true"
check_criterion "Service selector matches app=db" "$HAS_SELECTOR" && ((score++)) || true

# Check 4: Service port is 5432
SVC_PORT=$(kget "svc/db-headless" "q72" ".spec.ports[0].port")
HAS_PORT="false"
[ "$SVC_PORT" = "5432" ] && HAS_PORT="true"
check_criterion "Service port is 5432" "$HAS_PORT" && ((score++)) || true

print_score $score $total
