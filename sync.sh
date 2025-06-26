#!/bin/bash

REPO_PATH="/home/trent/resume"
REMOTE_RESUME_NAME="ResumeTrentWiles.pdf"
SITE_STORAGE_PATH="/var/www/html/trentwil.es/a/$REMOTE_RESUME_NAME"
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
    echo "No changes made to resume, nothing to do. Goodbye."
else
    # 3. If the resumes are not the same, copy the resume in this repo over
    #    to the storage folder of my website 
    rm -f $SITE_STORAGE_PATH
    cp trent_in_progress_resume.pdf $SITE_STORAGE_PATH

    # 4. Purge Cloudflare's cache so the newest version of the resume is
    #    available on the internet
    curl https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE/purge_cache \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
        -d "{\"files\": [\"https://trentwil.es/a/$REMOTE_RESUME_NAME\"]}"

    echo \n\n
    echo "Purged https://trentwil.es/a/$REMOTE_RESUME_NAME"
fi