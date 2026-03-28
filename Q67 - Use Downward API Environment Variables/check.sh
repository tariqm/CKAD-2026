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
# Q78 - Use Downward API Environment Variables
# ============================================================================
score=0
total=4

print_header "Q78 - Use Downward API Environment Variables"

# Check 1: Pod exists
EXISTS=$(resource_exists "pod/downward-env-pod" "q67")
check_criterion "Pod 'downward-env-pod' exists in namespace q67" "$EXISTS" && ((score++)) || true

# Check 2: POD_NAME env from fieldRef metadata.name
POD_JSON=$(kubectl get pod downward-env-pod -n q67 -o json 2>/dev/null)
HAS_POD_NAME="false"
if [ -n "$POD_JSON" ]; then
  HAS_POD_NAME=$(echo "$POD_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for c in data['spec']['containers']:
    for env in c.get('env', []):
        if env.get('name') == 'POD_NAME':
            vf = env.get('valueFrom', {}).get('fieldRef', {})
            if vf.get('fieldPath') == 'metadata.name':
                print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Env POD_NAME from fieldRef metadata.name" "$HAS_POD_NAME" && ((score++)) || true

# Check 3: POD_IP env from fieldRef status.podIP
HAS_POD_IP="false"
if [ -n "$POD_JSON" ]; then
  HAS_POD_IP=$(echo "$POD_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for c in data['spec']['containers']:
    for env in c.get('env', []):
        if env.get('name') == 'POD_IP':
            vf = env.get('valueFrom', {}).get('fieldRef', {})
            if vf.get('fieldPath') == 'status.podIP':
                print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Env POD_IP from fieldRef status.podIP" "$HAS_POD_IP" && ((score++)) || true

# Check 4: NODE_NAME env from fieldRef spec.nodeName
HAS_NODE_NAME="false"
if [ -n "$POD_JSON" ]; then
  HAS_NODE_NAME=$(echo "$POD_JSON" | python3 -c "
import sys, json
data = json.load(sys.stdin)
for c in data['spec']['containers']:
    for env in c.get('env', []):
        if env.get('name') == 'NODE_NAME':
            vf = env.get('valueFrom', {}).get('fieldRef', {})
            if vf.get('fieldPath') == 'spec.nodeName':
                print('true'); sys.exit(0)
print('false')
" 2>/dev/null)
fi
check_criterion "Env NODE_NAME from fieldRef spec.nodeName" "$HAS_NODE_NAME" && ((score++)) || true

print_score $score $total
