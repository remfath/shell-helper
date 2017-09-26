#!/usr/bin/env bash

# Loop date between the given range by asc sort
function getDateRangeAsc() {
  local rangeStart=$1
  local rangeEnd=$2
  local doSomething=$3

  rangeEnd=`date -d "+1 day $rangeEnd" +%Y%m%d`
  while [[ $rangeStart -lt $rangeEnd ]]
  do
    echo $rangeStart
    $doSomething
    wait
    rangeStart=`date -d "+1 day $rangeStart" +%Y%m%d`
  done
}

# Loop date between the given range by desc sort
function getDateRangeDesc() {
  local rangeStart=$1
  local rangeEnd=$2
  local doSomething=$3

  rangeStart=`date -d "-1 day $rangeStart" +%Y%m%d`
  while [[ $rangeEnd -gt $rangeStart ]]
  do
    echo $rangeEnd
    $doSomething
    wait
    rangeEnd=`date -d "-1 day $rangeEnd" +%Y%m%d`
  done
}

# Get hour part of a given second
function getHourPart() {
    local totalSeconds=$1
    local hourPart=$((totalSeconds/3600))

    echo $hourPart
    return 0
}

# Get minute part of a given second
function getMinutePart() {
    local totalSeconds=$1
    local hourPart=$(getHourPart "$totalSeconds")

    totalSeconds=$((totalSeconds - 3600 * hourPart))
    local minutePart=$((totalSeconds/60))

    echo $minutePart
    return 0
}

# Get second part of a given second
function getSecondPart() {
    local totalSeconds=$1
    local hourPart=$(getHourPart "$totalSeconds")
    local minutePart=$(getMinutePart "$totalSeconds")

    local secondPart=$((totalSeconds-3600*hourPart-60*minutePart))

    echo $secondPart
    return 0
}

# Format a given second to <Hour>h<Minute>m<Second>s
function formatTime() {
    local totalSeconds=$1
    local hourPart=$(getHourPart "${totalSeconds}")
    local minutePart=$(getMinutePart "${totalSeconds}")
    local secondPart=$(getSecondPart "${totalSeconds}")

    echo "${hourPart}h{minutePart}m${secondPart}s"
    return 0
}

# Get first day of a month that the given date belongs to
function getFirstDayOfMonth()
{
    local someDate=$1
    local thisYearMonth=`date +"%Ym" -d "${someDate}"`
    local firstDayOfDate="${thisYearMonth}01"

    echo $firstDayOfDate
    return 0
}

# Get the total days of a month that the given date belongs to
function getTotalDaysOfMonth()
{
    local someDate=$1
    local totalDays=`cal $(date +"%m %Y" -d "${someDate}") | awk 'NF {DAYS = $NF}; END {print DAYS}'`

    echo $totalDays
    return 0
}

# Get last day of a month that the given date belongs to
function getLastDayOfMonth()
{
    local someDate=$1
    local totalDays=$(getTotalDaysOfMonth "${someDate}")
    local thisYearMonth=`date +"%Y%m" -d "${someDate}"`
    local lastDayOfDate="${thisYearMonth}${totalDays}"

    echo $lastDayOfDate
    return 0
}



############################### Example ###############################

getDateRangeDesc 20170101 20170105 ""