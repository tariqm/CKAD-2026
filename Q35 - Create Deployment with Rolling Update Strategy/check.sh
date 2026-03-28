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
# Q35 CHECKS
# ============================================================================
score=0
total=5

print_header "Q35 - Create Deployment with Rolling Update Strategy"

# Check 1: Deployment exists
deploy_exists=$(resource_exists "deployment/rolling-app" "q35")
check_criterion "Deployment 'rolling-app' exists in namespace q35" "$deploy_exists" && ((score++)) || true

# Check 2: Replicas is 5
replicas=$(kget "deployment/rolling-app" "q35" ".spec.replicas")
correct_replicas="false"
[ "$replicas" = "5" ] && correct_replicas="true"
check_criterion "Deployment has 5 replicas" "$correct_replicas" && ((score++)) || true

# Check 3: Strategy is RollingUpdate
strategy=$(kget "deployment/rolling-app" "q35" ".spec.strategy.type")
correct_strategy="false"
[ "$strategy" = "RollingUpdate" ] && correct_strategy="true"
check_criterion "Strategy type is RollingUpdate" "$correct_strategy" && ((score++)) || true

# Check 4: maxSurge is 2
max_surge=$(kget "deployment/rolling-app" "q35" ".spec.strategy.rollingUpdate.maxSurge")
correct_surge="false"
[ "$max_surge" = "2" ] && correct_surge="true"
check_criterion "maxSurge is 2" "$correct_surge" && ((score++)) || true

# Check 5: maxUnavailable is 1
max_unavailable=$(kget "deployment/rolling-app" "q35" ".spec.strategy.rollingUpdate.maxUnavailable")
correct_unavailable="false"
[ "$max_unavailable" = "1" ] && correct_unavailable="true"
check_criterion "maxUnavailable is 1" "$correct_unavailable" && ((score++)) || true

print_score $score $total
