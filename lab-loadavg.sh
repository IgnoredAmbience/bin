#!/bin/bash
hosts=(edge matrix pixel visual)
counts=(28 23 37 23)
tmpfile=/tmp/uptime
outfile=hosts

if [ -n "$1" ]; then
  for h in `head -$1 $outfile`; do
    echo -n "$h: "
    ssh $h uptime
  done
  exit 0
fi


len=${#hosts[@]}
index=0

rm -f $tmpfile
while [ "$index" -lt "$len" ]
do
  for i in $(seq -w ${counts[$index]})
  do
    echo -n "${hosts[$index]}$i " | tee -a $tmpfile
    ssh -o "ConnectTimeout 5" ${hosts[$index]}$i cat /proc/loadavg >> $tmpfile || echo >> $tmpfile
  done
  ((index++))
done

sort -b -k 2 -g $tmpfile | grep / | awk '{print $1}' > $outfile
