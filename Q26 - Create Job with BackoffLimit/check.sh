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
# Q26 CHECKS
# ============================================================================
score=0
total=5

print_header "Q26 - Create Job with BackoffLimit"

# Check 1: Job exists
job_exists=$(resource_exists "job/backup-job" "q26")
check_criterion "Job 'backup-job' exists in namespace q26" "$job_exists" && ((score++)) || true

# Check 2: backoffLimit is 3
backoff=$(kget "job/backup-job" "q26" ".spec.backoffLimit")
has_backoff=$( [ "$backoff" = "3" ] && echo true || echo false )
check_criterion "backoffLimit is set to 3" "$has_backoff" && ((score++)) || true

# Check 3: completions is 1
completions=$(kget "job/backup-job" "q26" ".spec.completions")
has_completions=$( [ "$completions" = "1" ] && echo true || echo false )
check_criterion "completions is set to 1" "$has_completions" && ((score++)) || true

# Check 4: restartPolicy is Never
restart_policy=$(kget "job/backup-job" "q26" ".spec.template.spec.restartPolicy")
has_restart=$( [ "$restart_policy" = "Never" ] && echo true || echo false )
check_criterion "restartPolicy is Never" "$has_restart" && ((score++)) || true

# Check 5: Image is busybox:latest
image=$(kget "job/backup-job" "q26" ".spec.template.spec.containers[0].image")
has_image=$( echo "$image" | grep -q "busybox" && echo true || echo false )
check_criterion "Container image is busybox" "$has_image" && ((score++)) || true

print_score $score $total
