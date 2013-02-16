#!/bin/bash
hosts=(edge fusion glyph matrix pixel visual)
counts=(28 38 35 23 37 12 23)
tmpfile=/tmp/uptime

len=${#hosts[@]}
index=0

rm -f $tmpfile
while [ "$index" -lt "$len" ]
do
  for i in $(seq -w ${counts[$index]})
  do
    echo -n "${hosts[$index]}$i " | tee -a $tmpfile
    ssh ${hosts[$index]}$i cat /proc/loadavg >> $tmpfile || echo >> $tmpfile
  done
  ((index++))
done

sort -b -k 2 -g $tmpfile | awk '{print $1}'
