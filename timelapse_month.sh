#!/bin/sh
# Create timelapse from the previous day

YESTERDAY=$(date -d "yesterday" +"%Y%m%d")
LAST_MONTH=$(date -d "last month" +"%Y%m")
THIS_MONTH=$(date -d "this month" +"%Y%m")

IMAGE_DIR="/media/shankar/data/timelapse/"

FRONT_FILES="${IMAGE_DIR}front.txt"
BACK_FILES="${IMAGE_DIR}back.txt"

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_FRONT.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${FRONT_FILES}
done

for filename in "${IMAGE_DIR}${LAST_MONTH}"*_BACK.mp4; do
    [ -e "$filename" ] || continue
    echo "file '${filename}'" >> ${BACK_FILES}
done

# concat mp4s
ffmpeg -r 30 -f concat -safe 0 -i ${FRONT_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${LAST_MONTH}_FRONT.mp4
ffmpeg -r 30 -f concat -safe 0 -i ${BACK_FILES} -vcodec libx264 -crf 28 -preset veryslow -pix_fmt yuv420p ${IMAGE_DIR}${LAST_MONTH}_BACK.mp4 

# delete mp4s

# delete the front/back file lists
# # delete images used 
# # rm "${IMAGE_DIR}${YESTERDAY}*.jpg"
# find ${IMAGE_DIR} -type f -name "${YESTERDAY}*.jpg" -exec rm {} +

# Delete file list documents
rm ${FRONT_FILES}
rm ${BACK_FILES}

# Upload to youtube
