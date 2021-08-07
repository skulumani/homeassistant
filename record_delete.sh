#!/bin/sh
# record_delete.sh
# Record ip cam in segments

LQDIR="/media/shankar/usbdrive/video/low" # Do not include tail '/' (bash 'find' command will not execute property)
HQDIR="/media/shankar/usbdrive/video/high" # Do not include tail '/'

## Delete LQ files older than 7 days -mtime X is files strictly greater than X days old
find ${LQDIR} -maxdepth 1 -type f -mtime +20 -exec rm {} \;
## Delete HQ files older than 720 minutes
find ${HQDIR} -maxdepth 1 -type f -mtime +0 -exec rm {} \;
