#!/bin/bash

# Exit on error
set -e

# --- Colors for output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Argument checking ---
if [ -z "$1" ]; then
    echo -e "${RED}Usage: $0 <domain>${NC}"
    exit 1
fi

DOMAIN=$1
RESULTS_DIR="$DOMAIN"
SUBDOMAINS_FILE="$RESULTS_DIR/subdomains.txt"
LIVE_HOSTS_FILE="$RESULTS_DIR/live_hosts.txt"
NMAP_FILE="$RESULTS_DIR/nmap_scan.txt"

# --- Tool path ---
# Assuming the script is run from the root of the project
export PATH=$PATH:$(pwd)/bin

# --- Check if tools are installed ---
if ! command -v subfinder &> /dev/null || ! command -v httpx &> /dev/null || ! command -v nmap &> /dev/null; then
    echo -e "${RED}Error: One or more required tools (subfinder, httpx, nmap) are not found in the PATH.${NC}"
    echo -e "${YELLOW}Please run the setup.sh script first to install them.${NC}"
    exit 1
fi

# --- Create results directory ---
mkdir -p "$RESULTS_DIR"
echo -e "${GREEN}[+] Created results directory: $RESULTS_DIR${NC}"

# --- Start reconnaissance ---
echo -e "\n${YELLOW}[*] Starting reconnaissance for $DOMAIN...${NC}"

# --- Subdomain enumeration ---
echo -e "\n${GREEN}[+] Running subfinder for subdomain enumeration...${NC}"
subfinder -d "$DOMAIN" -o "$SUBDOMAINS_FILE" -silent
echo -e "${GREEN}[+] Subdomain enumeration complete. Results saved to $SUBDOMAINS_FILE${NC}"
echo -e "${YELLOW}[!] Found $(wc -l < "$SUBDOMAINS_FILE") subdomains.${NC}"

# --- Live host detection ---
echo -e "\n${GREEN}[+] Running httpx to find live web servers...${NC}"
cat "$SUBDOMAINS_FILE" | httpx -o "$LIVE_HOSTS_FILE" -silent
echo -e "${GREEN}[+] Live host detection complete. Results saved to $LIVE_HOSTS_FILE${NC}"
echo -e "${YELLOW}[!] Found $(wc -l < "$LIVE_HOSTS_FILE") live web servers.${NC}"

# --- Port scanning ---
echo -e "\n${GREEN}[+] Running nmap for port scanning on the root domain...${NC}"
nmap -sV -T4 "$DOMAIN" -oN "$NMAP_FILE" > /dev/null
echo -e "${GREEN}[+] Port scanning complete. Results saved to $NMAP_FILE${NC}"

# --- Summary ---
echo -e "\n${YELLOW}[*] Reconnaissance complete for $DOMAIN!${NC}"
echo -e "Results are saved in the '${GREEN}$RESULTS_DIR${NC}' directory."
echo -e "  - Subdomains: ${GREEN}$SUBDOMAINS_FILE${NC}"
echo -e "  - Live web servers: ${GREEN}$LIVE_HOSTS_FILE${NC}"
echo -e "  - Nmap scan: ${GREEN}$NMAP_FILE${NC}"
