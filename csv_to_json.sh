#!/bin/bash
infile='seg.csv'
outfile='segments_json.txt'
lc=`cat $infile | wc -l`
li=0
while [ $li -lt $lc ]
do
read each_line
if [ $li -eq 0 ]
  then
    cols=`echo $each_line | awk -F, {'print NF'}`
    ci=0
    while [ $ci -lt $cols ]
    do
      head_array[$ci]=$(echo $each_line | awk -v x=$(($ci + 1)) -F"," '{print $x}')
      ci=$(($ci+1))
    done
  else
    ci=0
    echo -n "{" >> $outfile
    while [ $ci -lt $cols ]
    do
      each_element=$(echo $each_line | awk -v y=$(($ci + 1)) -F"," '{print $y}')
      if [ $ci -ne $(($cols-1)) ]
        then
          echo -n ${head_array[$ci]}":"$each_element"," >> $outfile
        else
          echo -n ${head_array[$ci]}":"$each_element >> $outfile
      fi
      ci=$(($ci+1))
    done
    echo "}" >> $outfile
fi
li=$(($li+1))
done < $infile
