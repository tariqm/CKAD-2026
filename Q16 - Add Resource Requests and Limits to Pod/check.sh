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
    print_success "$description"
    return 0
  else
    print_fail "$description"
    return 1
  fi
}

resource_exists() { kubectl get "$1" -n "$2" >/dev/null 2>&1 && echo true || echo false; }
kget() { kubectl get "$1" -n "$2" -o jsonpath="{$3}" 2>/dev/null; }

# ============================================================================
# Question 16 | Resource Requests and Limits (5 points)
# ============================================================================
score=0
total=5
print_header "Question 16 | Resource Requests and Limits"

check_criterion "Pod resource-pod exists in q16" \
  "$(resource_exists pod/resource-pod q16)" && ((score++))

image=$(kget pod/resource-pod q16 '.spec.containers[0].image')
check_criterion "Image is nginx:latest" \
  "$(echo "$image" | grep -q "nginx" && echo true || echo false)" && ((score++))

cpu_limit=$(kget pod/resource-pod q16 '.spec.containers[0].resources.limits.cpu')
check_criterion "CPU limit is 1 (half of quota)" \
  "$([ "$cpu_limit" = "1" ] || [ "$cpu_limit" = "1000m" ] && echo true || echo false)" && ((score++))

mem_limit=$(kget pod/resource-pod q16 '.spec.containers[0].resources.limits.memory')
check_criterion "Memory limit is 2Gi (half of quota)" \
  "$([ "$mem_limit" = "2Gi" ] && echo true || echo false)" && ((score++))

cpu_req=$(kget pod/resource-pod q16 '.spec.containers[0].resources.requests.cpu')
check_criterion "CPU request is at least 100m" \
  "$([ -n "$cpu_req" ] && echo true || echo false)" && ((score++))

print_score $score $total
