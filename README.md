# BugBountyPro

A simple and powerful tool to automate the initial reconnaissance phase of your bug bounty hunting.

## Description

This tool is a one-command solution to perform initial reconnaissance on a target domain. It is designed to be simple to use, yet powerful enough to give you a head start in your bug bounty hunting journey.

## Features

*   **Subdomain Enumeration:** Discovers subdomains of a given domain.
*   **Live Host Detection:** Checks which of the discovered subdomains are running a web server.
*   **Port Scanning:** Scans for open ports on the target domain.

## Installation

To install the necessary tools, run the `setup.sh` script:

```bash
./setup.sh
```

## Usage

To run the tool, provide a domain name as an argument to the `bugbounty.sh` script:

```bash
./bugbounty.sh <domain>
```

For example:

```bash
./bugbounty.sh example.com
```

The tool will create a directory named after the target domain and save the results in it.
