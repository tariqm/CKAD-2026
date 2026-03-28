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
total=4

print_header "Q53 - Create Logging Sidecar Container"

# Check 1: pod exists
EXISTS=$(resource_exists "pod/app-with-sidecar-logging" "q53")
check_criterion "Pod 'app-with-sidecar-logging' exists in namespace q53" "$EXISTS" && ((score++)) || true

# Check 2: has container named "app"
APP_CONTAINER=$(kget "pod/app-with-sidecar-logging" "q53" ".spec.containers[?(@.name=='app')].name")
if [ "$APP_CONTAINER" = "app" ]; then
  HAS_APP="true"
else
  HAS_APP="false"
fi
check_criterion "Pod has container named 'app'" "$HAS_APP" && ((score++)) || true

# Check 3: has container named "sidecar"
SIDECAR_CONTAINER=$(kget "pod/app-with-sidecar-logging" "q53" ".spec.containers[?(@.name=='sidecar')].name")
if [ "$SIDECAR_CONTAINER" = "sidecar" ]; then
  HAS_SIDECAR="true"
else
  HAS_SIDECAR="false"
fi
check_criterion "Pod has container named 'sidecar'" "$HAS_SIDECAR" && ((score++)) || true

# Check 4: has volume named "log-vol"
LOG_VOL=$(kget "pod/app-with-sidecar-logging" "q53" ".spec.volumes[?(@.name=='log-vol')].name")
if [ "$LOG_VOL" = "log-vol" ]; then
  HAS_VOL="true"
else
  HAS_VOL="false"
fi
check_criterion "Pod has volume named 'log-vol'" "$HAS_VOL" && ((score++)) || true

print_score $score $total
