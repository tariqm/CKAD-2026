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
# Q89 - Create Ingress with TLS
# ============================================================================
print_header "Q89 - Create Ingress with TLS"

score=0
total=4

# Check 1: Ingress exists
ingress_exists=$(resource_exists "ingress/secure-ingress" "q78")
check_criterion "Ingress 'secure-ingress' exists in namespace q78" "$ingress_exists" && ((score++)) || true

# Check 2: Ingress has TLS block
tls_hosts=$(kget "ingress/secure-ingress" "q78" ".spec.tls[*].hosts[*]")
has_tls="false"
if [ -n "$tls_hosts" ]; then
  has_tls="true"
fi
check_criterion "Ingress has TLS configuration" "$has_tls" && ((score++)) || true

# Check 3: TLS references tls-secret
tls_secret=$(kget "ingress/secure-ingress" "q78" ".spec.tls[0].secretName")
tls_secret_correct="false"
if [ "$tls_secret" = "tls-secret" ]; then
  tls_secret_correct="true"
fi
check_criterion "TLS references secret 'tls-secret'" "$tls_secret_correct" && ((score++)) || true

# Check 4: Host is secure.example.com
host=$(kget "ingress/secure-ingress" "q78" ".spec.rules[0].host")
host_correct="false"
if [ "$host" = "secure.example.com" ]; then
  host_correct="true"
fi
check_criterion "Host is 'secure.example.com'" "$host_correct" && ((score++)) || true

print_score $score $total
