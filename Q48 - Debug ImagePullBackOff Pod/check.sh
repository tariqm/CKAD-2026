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
# Q54 CHECKS
# ============================================================================
score=0
total=2

print_header "Q54 - Debug ImagePullBackOff Pod"

# Check 1: pod exists
EXISTS=$(resource_exists "pod/bad-image-pod" "q48")
check_criterion "Pod 'bad-image-pod' exists in namespace q48" "$EXISTS" && ((score++)) || true

# Check 2: image is nginx:latest or nginx (not nonexistent)
IMAGE=$(kget "pod/bad-image-pod" "q48" ".spec.containers[0].image")
if echo "$IMAGE" | grep -qE '^nginx(:latest)?$'; then
  IMAGE_OK="true"
else
  IMAGE_OK="false"
fi
check_criterion "Image is nginx:latest (got: ${IMAGE:-none})" "$IMAGE_OK" && ((score++)) || true

print_score $score $total
