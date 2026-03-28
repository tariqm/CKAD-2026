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
# Q61 CHECKS
# ============================================================================
score=0
total=5

print_header "Q61 - Create LimitRange in Namespace"

# Check 1: LimitRange exists
LR_EXISTS=$(resource_exists "limitrange/default-limits" "q61")
check_criterion "LimitRange 'default-limits' exists in namespace q61" "$LR_EXISTS" && ((score++)) || true

# Check 2: Default CPU request
CPU_REQ=$(kget "limitrange/default-limits" "q61" ".spec.limits[0].defaultRequest.cpu")
CORRECT_CPU_REQ="false"
[ "$CPU_REQ" = "100m" ] && CORRECT_CPU_REQ="true"
check_criterion "Default CPU request is '100m'" "$CORRECT_CPU_REQ" && ((score++)) || true

# Check 3: Default CPU limit
CPU_LIM=$(kget "limitrange/default-limits" "q61" ".spec.limits[0].default.cpu")
CORRECT_CPU_LIM="false"
[ "$CPU_LIM" = "500m" ] && CORRECT_CPU_LIM="true"
check_criterion "Default CPU limit is '500m'" "$CORRECT_CPU_LIM" && ((score++)) || true

# Check 4: Default memory request
MEM_REQ=$(kget "limitrange/default-limits" "q61" ".spec.limits[0].defaultRequest.memory")
CORRECT_MEM_REQ="false"
[ "$MEM_REQ" = "128Mi" ] && CORRECT_MEM_REQ="true"
check_criterion "Default memory request is '128Mi'" "$CORRECT_MEM_REQ" && ((score++)) || true

# Check 5: Default memory limit
MEM_LIM=$(kget "limitrange/default-limits" "q61" ".spec.limits[0].default.memory")
CORRECT_MEM_LIM="false"
[ "$MEM_LIM" = "512Mi" ] && CORRECT_MEM_LIM="true"
check_criterion "Default memory limit is '512Mi'" "$CORRECT_MEM_LIM" && ((score++)) || true

print_score $score $total
