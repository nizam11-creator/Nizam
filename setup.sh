#!/bin/bash

# Exit on error
set -e

echo "Starting setup..."

# Install dependencies
echo "Installing nmap, wget, and unzip..."
sudo apt-get update -y
sudo apt-get install -y nmap wget unzip

# Create a bin directory
mkdir -p bin

# Download and install subfinder
echo "Downloading subfinder..."
SUBFINDER_URL="https://github.com/projectdiscovery/subfinder/releases/download/v2.8.0/subfinder_2.8.0_linux_amd64.zip"
wget -q $SUBFINDER_URL
unzip -o subfinder_2.8.0_linux_amd64.zip -d bin
rm subfinder_2.8.0_linux_amd64.zip

# Download and install httpx
echo "Downloading httpx..."
HTTPX_URL="https://github.com/projectdiscovery/httpx/releases/download/v1.7.1/httpx_1.7.1_linux_amd64.zip"
wget -q $HTTPX_URL
unzip -o httpx_1.7.1_linux_amd64.zip -d bin
rm httpx_1.7.1_linux_amd64.zip

echo ""
echo "Setup complete!"
echo "The tools have been installed in the 'bin' directory."
echo "Please add the 'bin' directory to your PATH by running this command:"
echo ""
echo "export PATH=\$PATH:$(pwd)/bin"
echo ""
echo "You can add this line to your ~/.bashrc or ~/.zshrc file to make it permanent."
