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
# Q62 CHECKS
# ============================================================================
score=0
total=5

print_header "Q62 - Use Projected Volume with Secret and ConfigMap"

# Check 1: Pod exists
POD_EXISTS=$(resource_exists "pod/projected-pod" "q62")
check_criterion "Pod 'projected-pod' exists in namespace q62" "$POD_EXISTS" && ((score++)) || true

# Check 2: Volume named combined-vol exists
VOL_NAME=$(kget "pod/projected-pod" "q62" ".spec.volumes[?(@.name=='combined-vol')].name")
HAS_VOL="false"
[ "$VOL_NAME" = "combined-vol" ] && HAS_VOL="true"
check_criterion "Pod has volume named 'combined-vol'" "$HAS_VOL" && ((score++)) || true

# Check 3: Volume is projected type with secret source
SECRET_SRC=$(kget "pod/projected-pod" "q62" ".spec.volumes[?(@.name=='combined-vol')].projected.sources[?(@.secret)].secret.name")
HAS_SECRET="false"
[ "$SECRET_SRC" = "app-secret" ] && HAS_SECRET="true"
check_criterion "Projected volume includes Secret 'app-secret'" "$HAS_SECRET" && ((score++)) || true

# Check 4: Volume has configmap source
CM_SRC=$(kget "pod/projected-pod" "q62" ".spec.volumes[?(@.name=='combined-vol')].projected.sources[?(@.configMap)].configMap.name")
HAS_CM="false"
[ "$CM_SRC" = "app-config" ] && HAS_CM="true"
check_criterion "Projected volume includes ConfigMap 'app-config'" "$HAS_CM" && ((score++)) || true

# Check 5: Volume is mounted at /etc/app-config
MOUNT_PATH=$(kget "pod/projected-pod" "q62" ".spec.containers[0].volumeMounts[?(@.name=='combined-vol')].mountPath")
CORRECT_MOUNT="false"
[ "$MOUNT_PATH" = "/etc/app-config" ] && CORRECT_MOUNT="true"
check_criterion "Volume mounted at '/etc/app-config'" "$CORRECT_MOUNT" && ((score++)) || true

print_score $score $total
