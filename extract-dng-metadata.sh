#!/bin/bash

CWD=`dirname $0`

EXIFTOOL=`(which exiftool 2>/dev/null)`

if [[ -z ${EXIFTOOL} ]]; then
  if [[ -d ${CWD}/exiftool ]]; then
    EXIFTOOL=${CWD}/exiftool/exiftool
  fi
fi

if [[ ! -z ${EXIFTOOL} ]]; then
  EXIFTOOL_OK=`(${EXIFTOOL} >/dev/null 2>/dev/null && echo "OK")`
fi

if [[ ($1 = "--help") || (-z ${EXIFTOOL_OK}) ]]; then
  echo "Usage:"
  echo "  $(basename $0) [filename.dng]"
  echo
  echo "Extracts DNG metadata from the given file and displays it on standard output."
  echo "If no filename is given, processes all DNG files in the current directory and"
  echo "writes the output to 'dng-metadata.txt'."
  echo
  echo "Requires 'exiftool' to be present along \$PATH or in the 'exiftool' subdirectory"
  echo "of the script folder (${CWD}/exiftool)."
  exit 1
fi

if [[ $1 != "" ]]; then
  ${EXIFTOOL} $1
else

  # Put everything into a single file

  find . -name '*.dng' | xargs ${EXIFTOOL} > dng-metadata.txt

  # Filter out redundant info, like file access times

  grep --invert-match '^File' dng-metadata.txt >temp.txt
  mv temp.txt dng-metadata.txt

  grep --invert-match '^Modify Date' dng-metadata.txt >temp.txt
  mv temp.txt dng-metadata.txt
fi
