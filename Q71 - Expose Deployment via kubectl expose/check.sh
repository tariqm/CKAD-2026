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
# Q82 - Expose Deployment via kubectl expose
# ============================================================================
score=0
total=4

print_header "Q82 - Expose Deployment via kubectl expose"

# Check 1: Service exists
EXISTS=$(resource_exists "svc/api-svc" "q71")
check_criterion "Service 'api-svc' exists in namespace q71" "$EXISTS" && ((score++)) || true

# Check 2: Service type is ClusterIP
SVC_TYPE=$(kget "svc/api-svc" "q71" ".spec.type")
IS_CLUSTER_IP="false"
[ "$SVC_TYPE" = "ClusterIP" ] && IS_CLUSTER_IP="true"
check_criterion "Service type is ClusterIP" "$IS_CLUSTER_IP" && ((score++)) || true

# Check 3: Service port is 8080
SVC_PORT=$(kget "svc/api-svc" "q71" ".spec.ports[0].port")
HAS_PORT="false"
[ "$SVC_PORT" = "8080" ] && HAS_PORT="true"
check_criterion "Service port is 8080" "$HAS_PORT" && ((score++)) || true

# Check 4: Service target port is 80
TARGET_PORT=$(kget "svc/api-svc" "q71" ".spec.ports[0].targetPort")
HAS_TARGET="false"
[ "$TARGET_PORT" = "80" ] && HAS_TARGET="true"
check_criterion "Service target port is 80" "$HAS_TARGET" && ((score++)) || true

print_score $score $total
