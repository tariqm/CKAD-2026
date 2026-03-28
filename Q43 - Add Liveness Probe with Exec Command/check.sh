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
# Q47 CHECKS
# ============================================================================
score=0
total=4

print_header "Q47 - Add Liveness Probe with Exec Command"

# Check 1: Pod exists
exists=$(resource_exists "pod/liveness-exec-pod" "q43")
check_criterion "Pod 'liveness-exec-pod' exists in namespace q43" "$exists" && ((score++)) || true

# Check 2: Has liveness probe
liveness=$(kget "pod/liveness-exec-pod" "q43" ".spec.containers[0].livenessProbe")
liveness_ok="false"
[ -n "$liveness" ] && liveness_ok="true"
check_criterion "Pod has a liveness probe configured" "$liveness_ok" && ((score++)) || true

# Check 3: Probe type is exec
exec_cmd=$(kget "pod/liveness-exec-pod" "q43" ".spec.containers[0].livenessProbe.exec.command")
exec_ok="false"
[ -n "$exec_cmd" ] && exec_ok="true"
check_criterion "Liveness probe type is exec" "$exec_ok" && ((score++)) || true

# Check 4: initialDelaySeconds is 5
init_delay=$(kget "pod/liveness-exec-pod" "q43" ".spec.containers[0].livenessProbe.initialDelaySeconds")
delay_ok="false"
[ "$init_delay" = "5" ] && delay_ok="true"
check_criterion "initialDelaySeconds is 5 (got: $init_delay)" "$delay_ok" && ((score++)) || true

print_score $score $total
