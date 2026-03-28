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
# Q31 CHECKS
# ============================================================================
score=0
total=4

print_header "Q31 - Create Deployment from Scratch with Port"

# Check 1: Deployment exists
deploy_exists=$(resource_exists "deployment/web-frontend" "q31")
check_criterion "Deployment 'web-frontend' exists in namespace q31" "$deploy_exists" && ((score++)) || true

# Check 2: Replicas is 4
replicas=$(kget "deployment/web-frontend" "q31" ".spec.replicas")
correct_replicas="false"
[ "$replicas" = "4" ] && correct_replicas="true"
check_criterion "Deployment has 4 replicas" "$correct_replicas" && ((score++)) || true

# Check 3: Image is httpd:latest
image=$(kget "deployment/web-frontend" "q31" ".spec.template.spec.containers[0].image")
correct_image="false"
[ "$image" = "httpd:latest" ] && correct_image="true"
check_criterion "Container image is httpd:latest" "$correct_image" && ((score++)) || true

# Check 4: containerPort is 80
port=$(kget "deployment/web-frontend" "q31" ".spec.template.spec.containers[0].ports[0].containerPort")
correct_port="false"
[ "$port" = "80" ] && correct_port="true"
check_criterion "Container port is 80" "$correct_port" && ((score++)) || true

print_score $score $total
