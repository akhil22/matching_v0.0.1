#!/bin/bash
search_folder="/home/akhil/visual_odom/seq_0/right_rijvi_match/*"
folder="/home/akhil/visual_odom/seq_0/right_rijvi_match"
images=()
j=0;
for i in $search_folder
do
images[$j]=$i
j=$(expr $j + "1")
done
tLen=$(expr ${#images[@]} - "1")
echo $tLen
for(( i=0; i<$tLen; i++));
do
k=$(expr $i + "1")
i1=$(expr $i + "3")
i2=$(expr $i + "4")
b="/home/akhil/right_rijvi_match_features/$k.txt"
im1="$folder/$i1.jpg"
im2="$folder/$i2.jpg"
key1="/home/akhil/visual_odom/seq_0/right_rijvi_keys/$i1"_"$k.key"
key2="/home/akhil/visual_odom/seq_0/right_rijvi_keys/$i2"_"$k.key"
result="/home/akhil/visual_odom/seq_0/right_rijvi_match_keys/$i1.txt"
echo $im1
echo $im2
echo $key1
echo $key2
./RunPairwise.sh $im1 $im2 $key1 $key2 $result
done


