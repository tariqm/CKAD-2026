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
# Q71 CHECKS
# ============================================================================
score=0
total=5

print_header "Q71 - Create ResourceQuota in Namespace"

# Check 1: ResourceQuota exists
RQ_EXISTS=$(resource_exists "resourcequota/compute-quota" "q60")
check_criterion "ResourceQuota 'compute-quota' exists in namespace q60" "$RQ_EXISTS" && ((score++)) || true

# Check 2: CPU requests limit
CPU_REQ=$(kget "resourcequota/compute-quota" "q60" ".spec.hard.requests\.cpu")
CORRECT_CPU_REQ="false"
[ "$CPU_REQ" = "1" ] && CORRECT_CPU_REQ="true"
check_criterion "CPU requests limit is '1'" "$CORRECT_CPU_REQ" && ((score++)) || true

# Check 3: CPU limits
CPU_LIM=$(kget "resourcequota/compute-quota" "q60" ".spec.hard.limits\.cpu")
CORRECT_CPU_LIM="false"
[ "$CPU_LIM" = "2" ] && CORRECT_CPU_LIM="true"
check_criterion "CPU limits is '2'" "$CORRECT_CPU_LIM" && ((score++)) || true

# Check 4: Memory requests limit
MEM_REQ=$(kget "resourcequota/compute-quota" "q60" ".spec.hard.requests\.memory")
CORRECT_MEM_REQ="false"
[ "$MEM_REQ" = "1Gi" ] && CORRECT_MEM_REQ="true"
check_criterion "Memory requests limit is '1Gi'" "$CORRECT_MEM_REQ" && ((score++)) || true

# Check 5: Memory limits
MEM_LIM=$(kget "resourcequota/compute-quota" "q60" ".spec.hard.limits\.memory")
CORRECT_MEM_LIM="false"
[ "$MEM_LIM" = "2Gi" ] && CORRECT_MEM_LIM="true"
check_criterion "Memory limits is '2Gi'" "$CORRECT_MEM_LIM" && ((score++)) || true

print_score $score $total
