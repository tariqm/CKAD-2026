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
# Q79 - Use Downward API Volume
# ============================================================================
score=0
total=3

print_header "Q79 - Use Downward API Volume"

# Check 1: Pod exists
EXISTS=$(resource_exists "pod/downward-vol-pod" "q68")
check_criterion "Pod 'downward-vol-pod' exists in namespace q68" "$EXISTS" && ((score++)) || true

# Check 2: Has downwardAPI volume
POD_JSON=$(kubectl get pod downward-vol-pod -n q68 -o json 2>/dev/null)
HAS_DOWNWARD_VOL="false"
if [ -n "$POD_JSON" ]; then
  HAS_DOWNWARD_VOL=$(echo "$POD_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for vol in data['spec'].get('volumes', []):
    if 'downwardAPI' in vol:
        print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Pod has a downwardAPI volume" "$HAS_DOWNWARD_VOL" && ((score++)) || true

# Check 3: Volume mounted at /etc/podinfo
HAS_MOUNT="false"
if [ -n "$POD_JSON" ]; then
  HAS_MOUNT=$(echo "$POD_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for c in data['spec']['containers']:
    for vm in c.get('volumeMounts', []):
        if vm.get('mountPath') == '/etc/podinfo':
            print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Volume mounted at /etc/podinfo" "$HAS_MOUNT" && ((score++)) || true

print_score $score $total
