#!/bin/bash

REPO_PATH="/home/trent/resume"
SITE_STORAGE_PATH="/var/www/html/trentwil.es/a/ResumeTrentWiles.pdf"
ENV_PATH=".env"

# 0. Load .env variables
set -o allexport
source $ENV_PATH
set +o allexport

# 1. Pull repo
cd $REPO_PATH
git pull

# 2. Compare MD5s

if [ "$(md5sum $SITE_STORAGE_PATH | cut -d ' ' -f 1)" = "$(md5sum trent_in_progress_resume.pdf | cut -d ' ' -f 1)" ]; then
  echo "Files are identical"
else
  echo "Files differ"
fi