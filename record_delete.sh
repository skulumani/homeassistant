#!/bin/sh
# record_delete.sh
# Record ip cam in segments

LQDIR="/media/data/video/low" # Do not include tail '/' (bash 'find' command will not execute property)
HQDIR="/media/data/video/high" # Do not include tail '/'

## Delete LQ files older than 90 days
find ${LQDIR} -maxdepth 1 -type f -mtime 90 -exec rm {} \;
## Delete HQ files older than 3 days
find ${HQDIR} -maxdepth 1 -type f -mtime 3 -exec rm {} \;
