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
# Q50 CHECKS
# ============================================================================
score=0
total=4

print_header "Q50 - Create Pod with All Three Probes"

# Check 1: pod exists
EXISTS=$(resource_exists "pod/triple-probe-pod" "q50")
check_criterion "Pod 'triple-probe-pod' exists in namespace q50" "$EXISTS" && ((score++)) || true

# Check 2: has startupProbe
STARTUP=$(kget "pod/triple-probe-pod" "q50" ".spec.containers[0].startupProbe.httpGet.port")
if [ -n "$STARTUP" ]; then
  HAS_STARTUP="true"
else
  HAS_STARTUP="false"
fi
check_criterion "Pod has startupProbe configured" "$HAS_STARTUP" && ((score++)) || true

# Check 3: has livenessProbe
LIVENESS=$(kget "pod/triple-probe-pod" "q50" ".spec.containers[0].livenessProbe.httpGet.port")
if [ -n "$LIVENESS" ]; then
  HAS_LIVENESS="true"
else
  HAS_LIVENESS="false"
fi
check_criterion "Pod has livenessProbe configured" "$HAS_LIVENESS" && ((score++)) || true

# Check 4: has readinessProbe
READINESS=$(kget "pod/triple-probe-pod" "q50" ".spec.containers[0].readinessProbe.httpGet.port")
if [ -n "$READINESS" ]; then
  HAS_READINESS="true"
else
  HAS_READINESS="false"
fi
check_criterion "Pod has readinessProbe configured" "$HAS_READINESS" && ((score++)) || true

print_score $score $total
