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
# Q30 CHECKS
# ============================================================================
score=0
total=4

print_header "Q30 - Create Deployment with Multiple Containers"

# Check 1: Deployment exists
deploy_exists=$(resource_exists "deployment/multi-deploy" "q30")
check_criterion "Deployment 'multi-deploy' exists in namespace q30" "$deploy_exists" && ((score++)) || true

# Check 2: Replicas is 2
replicas=$(kget "deployment/multi-deploy" "q30" ".spec.replicas")
correct_replicas="false"
[ "$replicas" = "2" ] && correct_replicas="true"
check_criterion "Deployment has 2 replicas" "$correct_replicas" && ((score++)) || true

# Check 3: Has container "web"
containers=$(kget "deployment/multi-deploy" "q30" ".spec.template.spec.containers[*].name")
has_web="false"
echo "$containers" | grep -q "web" && has_web="true"
check_criterion "Deployment has container named 'web'" "$has_web" && ((score++)) || true

# Check 4: Has container "metrics"
has_metrics="false"
echo "$containers" | grep -q "metrics" && has_metrics="true"
check_criterion "Deployment has container named 'metrics'" "$has_metrics" && ((score++)) || true

print_score $score $total
