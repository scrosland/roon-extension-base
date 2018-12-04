#!/bin/sh
/app/tstamp /app/lib/check-for-updates.sh 2>&1 |
    tee -a $DATA/logs/check-for-updates.log
