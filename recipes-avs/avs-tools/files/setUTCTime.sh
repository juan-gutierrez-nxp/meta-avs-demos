#!/bin/sh

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

UTCDATE="$(timeout 5 curl http://s3.amazonaws.com -v 2>&1 | grep "Date: " | awk '{ print $3 " " $5 " " $4 " " $7 " " $6 " GMT"}')"

if [ -n "$UTCDATE" ]; then
  date -s "$UTCDATE"
else
  echo    "============================================================="
  echo -e "${YELLOW}"
  echo    " WARNING: There were a problem updating the date to UTC time "
  echo    " Please set the current UTC date manually by something like: "
  echo    ""
  echo    "     date -s \"Tue Jun 26 23:20:17 UTC 2018\"                "
  echo -e "${NC}"
  echo    "============================================================="
fi
