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
# Question 14 | Create Ingress Resource (4 points)
# ============================================================================
score=0
total=4
print_header "Question 14 | Create Ingress Resource"

check_criterion "Ingress web-ingress exists in q14" \
  "$(resource_exists ingress/web-ingress q14)" && ((score++))

host=$(kget ingress/web-ingress q14 '.spec.rules[0].host')
check_criterion "Host is web.example.com" \
  "$([ "$host" = "web.example.com" ] && echo true || echo false)" && ((score++))

pt=$(kget ingress/web-ingress q14 '.spec.rules[0].http.paths[0].pathType')
check_criterion "pathType is Prefix" \
  "$([ "$pt" = "Prefix" ] && echo true || echo false)" && ((score++))

backend_name=$(kget ingress/web-ingress q14 '.spec.rules[0].http.paths[0].backend.service.name')
backend_port=$(kget ingress/web-ingress q14 '.spec.rules[0].http.paths[0].backend.service.port.number')
check_criterion "Backend is web-svc:8080" \
  "$([ "$backend_name" = "web-svc" ] && [ "$backend_port" = "8080" ] && echo true || echo false)" && ((score++))

print_score $score $total
