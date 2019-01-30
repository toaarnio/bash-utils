#!/bin/bash
#

if [ -z "$1" ]; then
  echo "Usage: fix-video-dates.sh <root directory>"
  echo "Example: fix-video-dates.sh /media/LaCie/Videos"
  exit 1
fi

find ${1} -type f |
while read fname
do
  TIMESTAMP=$(mediainfo ${fname} | grep -i --max-count=1 'date.*20[01][0-9]' | cut --characters=44- -)
  if [ -z "${TIMESTAMP}" ]; then
    echo "No valid timestamp found for ${fname}; skipping."
  else
    echo ${fname} ${TIMESTAMP}
    touch -d "${TIMESTAMP}" "${fname}"
  fi
done
