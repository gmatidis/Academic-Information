#!/bin/bash

scriptname=$(basename $0 | cut -f 1 -d '.')
lock="/opt/amc/mies/cron_files_dcmhub/${scriptname}.lock"

exec 500>>$lock
flock -n 500 || exit 0

source /opt/amc/mies/mies-venv/bin/activate
python /opt/amc/mies/main.py prepare

rm $lock
