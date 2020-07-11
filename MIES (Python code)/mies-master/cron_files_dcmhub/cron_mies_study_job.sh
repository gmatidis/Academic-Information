#!/bin/bash

scriptname=$(basename $0 | cut -f 1 -d '.')
lock="/opt/amc/mies/cron_files_dcmhub/${scriptname}.lock"

exec 200>>$lock
flock -n 200 || exit 0

source /opt/amc/mies/mies-venv/bin/activate
python /opt/amc/mies/main.py study auto
python /opt/amc/mies/main.py job

rm $lock
