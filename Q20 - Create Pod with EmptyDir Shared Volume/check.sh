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
# Q20 CHECKS
# ============================================================================
score=0
total=4

print_header "Q20 - Create Pod with EmptyDir Shared Volume"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/shared-vol-pod" "q20")
check_criterion "Pod 'shared-vol-pod' exists in namespace q20" "$pod_exists" && ((score++)) || true

# Check 2: Pod has 2 containers
container_count=$(kubectl get pod shared-vol-pod -n q20 -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w | tr -d ' ')
has_two=$( [ "$container_count" -eq 2 ] 2>/dev/null && echo true || echo false )
check_criterion "Pod has exactly 2 containers" "$has_two" && ((score++)) || true

# Check 3: Volume named shared-data exists
volume_names=$(kget "pod/shared-vol-pod" "q20" ".spec.volumes[*].name")
has_volume=$( echo "$volume_names" | grep -q "shared-data" && echo true || echo false )
check_criterion "Volume 'shared-data' exists" "$has_volume" && ((score++)) || true

# Check 4: Volume type is emptyDir
emptydir_check=$(kubectl get pod shared-vol-pod -n q20 -o jsonpath='{.spec.volumes[?(@.name=="shared-data")].emptyDir}' 2>/dev/null)
is_emptydir=$( [ -n "$emptydir_check" ] && echo true || echo false )
check_criterion "Volume 'shared-data' is of type emptyDir" "$is_emptydir" && ((score++)) || true

print_score $score $total
