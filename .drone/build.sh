#!/usr/bin/env bash
VERSION="$(git rev-parse --short HEAD)"

echo "Started building at $(date) - $(whoami)"

# Update composer
composer self-update

# Install dependencies
composer install --no-interaction --no-progress

cp jorobo.dist.ini jorobo.ini
cp RoboFile.dist.ini RoboFile.ini

# Make sure the path to the CMS is inside the apache config for docker
sed -i 's!^cmsPath\s*=\s*(.*)!\/tests\/joomla/$1!' RoboFile.ini

# Build package
vendor/bin/robo build --dev

# Copy acceptance yml
cp tests/acceptance.suite.dist.yml tests/acceptance.suite.yml
