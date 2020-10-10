#!/bin/sh
# record_delete.sh
# Record ip cam in segments

LQDIR="/media/data/video/low" # Do not include tail '/' (bash 'find' command will not execute property)
HQDIR="/media/data/video/high" # Do not include tail '/'

## Delete LQ files older than 7 days
find ${LQDIR} -maxdepth 1 -type f -mtime 7 -exec rm {} \;
## Delete HQ files older than 720 minutes
find ${HQDIR} -maxdepth 1 -type f -mmin 720 -exec rm {} \;