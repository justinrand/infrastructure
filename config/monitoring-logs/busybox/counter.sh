#!/bin/sh                                                                                                                                                              
[  -z "$1" ] && LOG1="log1.log" || LOG1=$1
[  -z "$2" ] && LOG2="log2.log" || LOG2=$2
i=0;
while true;                                                                                                                                                               
  do
    echo "Log1: $i: $(date)" >> $LOG1;
    echo "Log2: $(date) INFO $i" >> $LOG2;
    i=$((i+1));
    sleep 1;
  done
