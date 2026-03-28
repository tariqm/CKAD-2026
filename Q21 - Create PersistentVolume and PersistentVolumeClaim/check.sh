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
# Q21 CHECKS
# ============================================================================
score=0
total=4

print_header "Q21 - Create PersistentVolume and PersistentVolumeClaim"

# Check 1: PV exists (cluster-scoped, no namespace)
pv_exists=$(kubectl get pv task-pv >/dev/null 2>&1 && echo true || echo false)
check_criterion "PersistentVolume 'task-pv' exists" "$pv_exists" && ((score++)) || true

# Check 2: PV capacity is 1Gi
pv_capacity=$(kubectl get pv task-pv -o jsonpath='{.spec.capacity.storage}' 2>/dev/null)
has_capacity=$( [ "$pv_capacity" = "1Gi" ] && echo true || echo false )
check_criterion "PV capacity is 1Gi" "$has_capacity" && ((score++)) || true

# Check 3: PVC exists in q21
pvc_exists=$(resource_exists "pvc/task-pvc" "q21")
check_criterion "PersistentVolumeClaim 'task-pvc' exists in namespace q21" "$pvc_exists" && ((score++)) || true

# Check 4: PVC is Bound
pvc_phase=$(kget "pvc/task-pvc" "q21" ".status.phase")
is_bound=$( [ "$pvc_phase" = "Bound" ] && echo true || echo false )
check_criterion "PVC is in Bound state" "$is_bound" && ((score++)) || true

print_score $score $total
