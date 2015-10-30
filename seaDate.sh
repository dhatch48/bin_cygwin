#!/bin/bash

DATE=$1
REGEX="^(..)(..?)(.)$"

[[ $DATE =~ $REGEX ]]
YEAR=$(( ${BASH_REMATCH[1]} + 1999 ))
WEEK=$(( ${BASH_REMATCH[2]} - 1))
DAYOFWEEK=$(( ${BASH_REMATCH[3]} - 1))


OFFSET=$(( 6 - $(date -d "$YEAR-07-01" +%u) ))
DATEOFFIRSTSATURDAY=$(date -d "$YEAR-7-01 $OFFSET days" +%d)
FINALDATE=`date -d  "$YEAR-07-$DATEOFFIRSTSATURDAY $WEEK weeks $DAYOFWEEK days"`

echo $FINALDATE
