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
# Q69 - Create Docker Registry Secret
# ============================================================================
score=0
total=4

print_header "Q69 - Create Docker Registry Secret"

# Check 1: Secret exists
EXISTS=$(resource_exists "secret/my-registry-secret" "q69")
check_criterion "Secret 'my-registry-secret' exists in namespace q69" "$EXISTS" && ((score++)) || true

# Check 2: Secret type is docker-registry
SECRET_TYPE=$(kget "secret/my-registry-secret" "q69" ".type")
IS_DOCKER_REG="false"
[ "$SECRET_TYPE" = "kubernetes.io/dockerconfigjson" ] && IS_DOCKER_REG="true"
check_criterion "Secret type is kubernetes.io/dockerconfigjson" "$IS_DOCKER_REG" && ((score++)) || true

# Check 3: Pod exists
POD_EXISTS=$(resource_exists "pod/registry-pod" "q69")
check_criterion "Pod 'registry-pod' exists in namespace q69" "$POD_EXISTS" && ((score++)) || true

# Check 4: Pod uses imagePullSecrets
HAS_PULL_SECRET="false"
if [ "$POD_EXISTS" = "true" ]; then
  PULL_SECRET=$(kget "pod/registry-pod" "q69" ".spec.imagePullSecrets[0].name")
  [ "$PULL_SECRET" = "my-registry-secret" ] && HAS_PULL_SECRET="true"
fi
check_criterion "Pod uses 'my-registry-secret' as imagePullSecret" "$HAS_PULL_SECRET" && ((score++)) || true

print_score $score $total
