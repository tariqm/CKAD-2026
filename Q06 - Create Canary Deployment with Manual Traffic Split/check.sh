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
# Question 6 | Canary Deployment with Manual Traffic Split (4 points)
# ============================================================================
score=0
total=4
print_header "Question 6 | Canary Deployment with Manual Traffic Split"

replicas=$(kget deploy/web-app q06 '.spec.replicas')
check_criterion "Deployment web-app has 8 replicas" \
  "$([ "$replicas" = "8" ] && echo true || echo false)" && ((score++))

check_criterion "Deployment web-app-canary exists" \
  "$(resource_exists deploy/web-app-canary q06)" && ((score++))

canary_replicas=$(kget deploy/web-app-canary q06 '.spec.replicas')
check_criterion "Deployment web-app-canary has 2 replicas" \
  "$([ "$canary_replicas" = "2" ] && echo true || echo false)" && ((score++))

canary_label=$(kget deploy/web-app-canary q06 '.spec.template.metadata.labels.app')
check_criterion "Canary pods have label app=webapp" \
  "$([ "$canary_label" = "webapp" ] && echo true || echo false)" && ((score++))

print_score $score $total
