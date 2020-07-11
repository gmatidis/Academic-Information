#!/bin/bash

HOST=`hostname -s`

for DD in data opt scratch tmp var home
do
    PERCENT=`df /${DD} | tail -n1 | sed 's/.* \([0-9]*\)%.*/\1/'`
    (( $PERCENT > 90 )) | exit 1
done

set -e

scriptname=$(basename $0 | cut -f 1 -d '.')
lock="/opt/amc/mies/cron_files_dcmhub/${scriptname}.lock"

exec 400>>$lock
flock -n 400 || exit 0

source /opt/amc/mies/mies-venv/bin/activate
python /opt/amc/mies/main.py move

rm $lock
