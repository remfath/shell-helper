#!/usr/bin/env bash

# Loop date between the given range by asc sort
function getDateRangeAsc() {
  rangeStart=$1
  rangeEnd=$2
  doSomething=$3

  rangeEnd=`date -d "+1 day $rangeEnd" +%Y%m%d`
  while [[ $rangeStart -lt $rangeEnd ]]
  do
    echo $rangeStart
    $doSomething
    wait
    rangeStart=`date -d "+1 day $rangeStart" +%Y%m%d`
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



############################### Example ###############################

getDateRangeAsc 20170101 20170105 "echo hi"