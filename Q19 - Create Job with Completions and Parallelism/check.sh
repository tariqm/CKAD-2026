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
# Q19 CHECKS
# ============================================================================
score=0
total=4

print_header "Q19 - Create Job with Completions and Parallelism"

# Check 1: Job exists
job_exists=$(resource_exists "job/batch-job" "q19")
check_criterion "Job 'batch-job' exists in namespace q19" "$job_exists" && ((score++)) || true

# Check 2: Completions is 5
completions=$(kget "job/batch-job" "q19" ".spec.completions")
has_completions=$( [ "$completions" = "5" ] && echo true || echo false )
check_criterion "Job completions is set to 5" "$has_completions" && ((score++)) || true

# Check 3: Parallelism is 2
parallelism=$(kget "job/batch-job" "q19" ".spec.parallelism")
has_parallelism=$( [ "$parallelism" = "2" ] && echo true || echo false )
check_criterion "Job parallelism is set to 2" "$has_parallelism" && ((score++)) || true

# Check 4: restartPolicy is Never
restart_policy=$(kget "job/batch-job" "q19" ".spec.template.spec.restartPolicy")
has_restart=$( [ "$restart_policy" = "Never" ] && echo true || echo false )
check_criterion "restartPolicy is Never" "$has_restart" && ((score++)) || true

print_score $score $total
