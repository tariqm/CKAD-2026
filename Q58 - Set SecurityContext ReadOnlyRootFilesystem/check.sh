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
# Q58 CHECKS
# ============================================================================
score=0
total=4

print_header "Q58 - Set SecurityContext ReadOnlyRootFilesystem"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/readonly-pod" "q58")
check_criterion "Pod 'readonly-pod' exists in namespace q58" "$pod_exists" && ((score++)) || true

# Check 2: readOnlyRootFilesystem is true
readonly_fs=$(kget "pod/readonly-pod" "q58" ".spec.containers[0].securityContext.readOnlyRootFilesystem")
is_readonly=$( [ "$readonly_fs" = "true" ] && echo true || echo false )
check_criterion "Container securityContext readOnlyRootFilesystem is true" "$is_readonly" && ((score++)) || true

# Check 3: Has emptyDir volume
empty_dir_vol=$(kget "pod/readonly-pod" "q58" ".spec.volumes[?(@.emptyDir)].name")
has_emptydir=$( [ -n "$empty_dir_vol" ] && echo true || echo false )
check_criterion "Pod has an emptyDir volume" "$has_emptydir" && ((score++)) || true

# Check 4: Volume mounted at /tmp
mount_path=$(kget "pod/readonly-pod" "q58" ".spec.containers[0].volumeMounts[?(@.mountPath=='/tmp')].mountPath")
has_tmp_mount=$( [ "$mount_path" = "/tmp" ] && echo true || echo false )
check_criterion "emptyDir volume mounted at /tmp" "$has_tmp_mount" && ((score++)) || true

print_score $score $total
