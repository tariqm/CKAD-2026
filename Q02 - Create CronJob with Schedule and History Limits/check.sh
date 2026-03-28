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
  [ "$total" -gt 0 ] && pct=$(( score * 100 / total ))
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
# Question 2 | Create CronJob with Schedule and History Limits (6 points)
# ============================================================================
score=0
total=6
print_header "Question 2 | Create CronJob with Schedule and History Limits"

check_criterion "CronJob backup-job exists in q02" \
  "$(resource_exists cronjob/backup-job q02)" && ((score++))

schedule=$(kget cronjob/backup-job q02 '.spec.schedule')
check_criterion "Schedule is */30 * * * *" \
  "$([ "$schedule" = "*/30 * * * *" ] && echo true || echo false)" && ((score++))

shl=$(kget cronjob/backup-job q02 '.spec.successfulJobsHistoryLimit')
check_criterion "successfulJobsHistoryLimit is 3" \
  "$([ "$shl" = "3" ] && echo true || echo false)" && ((score++))

fhl=$(kget cronjob/backup-job q02 '.spec.failedJobsHistoryLimit')
check_criterion "failedJobsHistoryLimit is 2" \
  "$([ "$fhl" = "2" ] && echo true || echo false)" && ((score++))

ads=$(kget cronjob/backup-job q02 '.spec.jobTemplate.spec.activeDeadlineSeconds')
check_criterion "activeDeadlineSeconds is 300" \
  "$([ "$ads" = "300" ] && echo true || echo false)" && ((score++))

rp=$(kget cronjob/backup-job q02 '.spec.jobTemplate.spec.template.spec.restartPolicy')
check_criterion "restartPolicy is Never" \
  "$([ "$rp" = "Never" ] && echo true || echo false)" && ((score++))

print_score $score $total
