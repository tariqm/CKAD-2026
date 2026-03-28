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
# Q67 CHECKS
# ============================================================================
score=0
total=3

print_header "Q67 - Create ClusterRole and ClusterRoleBinding"

# Check 1: ClusterRole exists (cluster-scoped, no namespace)
cr_exists=$(kubectl get clusterrole node-viewer >/dev/null 2>&1 && echo true || echo false)
check_criterion "ClusterRole 'node-viewer' exists" "$cr_exists" && ((score++)) || true

# Check 2: ClusterRoleBinding exists (cluster-scoped, no namespace)
crb_exists=$(kubectl get clusterrolebinding cluster-viewer-binding >/dev/null 2>&1 && echo true || echo false)
check_criterion "ClusterRoleBinding 'cluster-viewer-binding' exists" "$crb_exists" && ((score++)) || true

# Check 3: ClusterRoleBinding references ServiceAccount cluster-viewer in q56
sa_name=$(kubectl get clusterrolebinding cluster-viewer-binding -o jsonpath='{.subjects[?(@.kind=="ServiceAccount")].name}' 2>/dev/null)
sa_ns=$(kubectl get clusterrolebinding cluster-viewer-binding -o jsonpath='{.subjects[?(@.kind=="ServiceAccount")].namespace}' 2>/dev/null)
refs_sa=$( [ "$sa_name" = "cluster-viewer" ] && [ "$sa_ns" = "q56" ] && echo true || echo false )
check_criterion "ClusterRoleBinding references SA 'cluster-viewer' in namespace q56" "$refs_sa" && ((score++)) || true

print_score $score $total
