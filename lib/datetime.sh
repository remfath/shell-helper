
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
