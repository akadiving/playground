#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${DIR}"/../.env
source "${DIR}"/styles.env
source "${DIR}"/functions.sh

clear

echo -e "${COLOR_BLUE}Welcome to SWEEFT API installer!${COLOR_NONE}\n"

TOTAL_STEPS=5
CURRENT_STEP=0

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Create directories...\n\v${COLOR_NONE}"
mkdir "${DIR}"/../services/api || echo "OK"
mkdir "${DIR}"/../services/docs || echo "OK"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning API repository...\n\v${COLOR_NONE}"
clone_repository "${ON_WEBSITE_GIT_REPO}" "${ON_WEBSITE_DIR}"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Cloning Docs repository...\n\v${COLOR_NONE}"
clone_repository "${DOCS_GIT_REPO}" "${DOCS_DIR}"

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Building images...\n\v${COLOR_NONE}"
docker build -t on-ge/php dockerfiles/php
docker-compose build

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Building containers...\n\v${COLOR_NONE}"
docker-compose pull
docker-compose up -d --remove-orphans

CURRENT_STEP=$((CURRENT_STEP + 1))
echo -e "\n\v${COLOR_BLUE}[${CURRENT_STEP}/${TOTAL_STEPS}] Setting up containers...\n\v${COLOR_NONE}"
bash "${DIR}"/buildpoints.sh
echo -e "\n\v${COLOR_BLUE}Containers has been Installed and are running.\n\v${COLOR_NONE}"