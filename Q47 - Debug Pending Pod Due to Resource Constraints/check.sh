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
# Q53 CHECKS
# ============================================================================
score=0
total=3

print_header "Q53 - Debug Pending Pod Due to Resource Constraints"

# Check 1: fixed-pod exists in q47
EXISTS=$(resource_exists "pod/fixed-pod" "q47")
check_criterion "Pod 'fixed-pod' exists in namespace q47" "$EXISTS" && ((score++)) || true

# Check 2: pod is Running or at least not rejected (status is not empty)
POD_PHASE=$(kget "pod/fixed-pod" "q47" ".status.phase")
if [ "$POD_PHASE" = "Running" ] || [ "$POD_PHASE" = "Pending" ] || [ "$POD_PHASE" = "Succeeded" ]; then
  IS_SCHEDULED="true"
else
  IS_SCHEDULED="false"
fi
check_criterion "Pod 'fixed-pod' is Running or Pending (not rejected by quota)" "$IS_SCHEDULED" && ((score++)) || true

# Check 3: CPU request is <= 100m
CPU_REQ=$(kget "pod/fixed-pod" "q47" ".spec.containers[0].resources.requests.cpu")
# Convert to millicores for comparison
if echo "$CPU_REQ" | grep -q 'm$'; then
  CPU_VAL=$(echo "$CPU_REQ" | sed 's/m$//')
else
  CPU_VAL=$((${CPU_REQ:-999} * 1000))
fi
if [ "${CPU_VAL:-999}" -le 100 ] 2>/dev/null; then
  CPU_OK="true"
else
  CPU_OK="false"
fi
check_criterion "CPU request is <= 100m (got: ${CPU_REQ:-none})" "$CPU_OK" && ((score++)) || true

print_score $score $total
