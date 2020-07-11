#!/bin/bash

scriptname=$(basename $0 | cut -f 1 -d '.')
lock="/opt/amc/mies/cron_files_dcmhub/${scriptname}.lock"

exec 300>>$lock
flock -n 300 || exit 0

source /opt/amc/mies/mies-venv/bin/activate
python /opt/amc/mies/main.py find

rm $lock
