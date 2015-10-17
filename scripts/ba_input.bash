#!/bin/bash
BINPATH=../bin/KeyMatchGeometryAware
search_folder="/home/akhil/visual_odom/seq_0/rijvi_list_keys/*"
folder="/home/akhil/visual_odom/seq_0/rijvi_list_keys"
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
keyfile="/home/akhil/visual_odom/seq_0/rijvi_list_keys/$k.txt"
dimfile="/home/akhil/visual_odom/seq_0/dims.init.txt"
key1="/home/akhil/visual_odom/seq_0/right_rijvi_keys/$i1"_"$k.key"
key2="/home/akhil/visual_odom/seq_0/right_rijvi_keys/$i2"_"$k.key"
result="/home/akhil/visual_odom/seq_0/rijvi_tracks/$i1.txt"
echo $im1
echo $im2
echo $key1
echo $key2
$BINPATH --keyfile_list=$keyfile --image_dimension_list=/home/akhil/visual_odom/seq_0/dims.init.txt --matches_file=$result 
done


