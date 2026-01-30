#!/bin/bash

exiftool -ee3 -U -G3:1 -api requestall=3 -api largefilesupport $*
