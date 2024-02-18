#!/bin/bash

BOLD=$(tput bold)
GRAY=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

RESET=$(tput sgr0)

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker not installed! Please install Docker first...${RESET}"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose not installed! Please install Docker Compose first...${RESET}"
    exit 1
fi

# Get container names
containers=("nginx" "database" "PHP" "redis" "phpmyadmin")

# Check if Docker containers are created
for container in "${containers[@]}"; do
    if ! docker ps -a --format '{{.Names}}' | grep -q "$container"; then
        echo -e "${RED}Container $container not found. Make sure all LNMP containers are created...${RESET}"
        exit 1
    fi
done

# Check if database containers exist
database_containers=("MySQL" "MariaDB" "MongoDB" "sqlite")
for db_container in "${database_containers[@]}"; do
    if ! docker ps -a --format '{{.Names}}' | grep -q "$db_container"; then
        echo -e "${RED}Database container $db_container not found. Make sure all LNMP database containers are created...${RESET}"
        exit 1
    fi
done

# Execute LNMP script
echo -e "${BOLD}${YELLOW}All prerequisites met. Executing LNMP script...${RESET}"
# Add the command to execute the LNMP script
