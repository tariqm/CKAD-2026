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
# Q25 CHECKS
# ============================================================================
score=0
total=6

print_header "Q25 - Build Multi-Container Pod with Log Aggregator"

# Check 1: Pod exists
pod_exists=$(resource_exists "pod/log-aggregator" "q25")
check_criterion "Pod 'log-aggregator' exists in namespace q25" "$pod_exists" && ((score++)) || true

# Check 2: Pod has 2 containers
container_count=$(kubectl get pod log-aggregator -n q25 -o jsonpath='{.spec.containers[*].name}' 2>/dev/null | wc -w | tr -d ' ')
has_two_containers=$( [ "$container_count" -eq 2 ] 2>/dev/null && echo true || echo false )
check_criterion "Pod has exactly 2 containers" "$has_two_containers" && ((score++)) || true

# Check 3: Container named 'writer' exists
container_names=$(kget "pod/log-aggregator" "q25" ".spec.containers[*].name")
has_writer=$( echo "$container_names" | grep -q "writer" && echo true || echo false )
check_criterion "Container 'writer' exists" "$has_writer" && ((score++)) || true

# Check 4: Container named 'reader' exists
has_reader=$( echo "$container_names" | grep -q "reader" && echo true || echo false )
check_criterion "Container 'reader' exists" "$has_reader" && ((score++)) || true

# Check 5: Shared volume 'shared-logs' exists
volume_names=$(kget "pod/log-aggregator" "q25" ".spec.volumes[*].name")
has_shared_volume=$( echo "$volume_names" | grep -q "shared-logs" && echo true || echo false )
check_criterion "Shared volume 'shared-logs' exists" "$has_shared_volume" && ((score++)) || true

# Check 6: Pod is in Running state
pod_phase=$(kget "pod/log-aggregator" "q25" ".status.phase")
is_running=$( [ "$pod_phase" = "Running" ] && echo true || echo false )
check_criterion "Pod is in Running state" "$is_running" && ((score++)) || true

print_score $score $total
