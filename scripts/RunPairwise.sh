#!/bin/bash
#
# RunPairwise.sh
#   copyright 2015 Rajvi Shah
#
# A script for preparing options and running pairwise matching 

if [ $# -ne 5 ]
then
  echo "[RunPairwise] USAGE: ./RunPairwise.sh <ImagePath1> <ImagePath2> <Key1ResultPath> <Key2Resultpath> <MatchResultPath>"  
  exit
fi

IMAGE1=$1
IMAGE2=$2
RESULT=$5
key_file1=$3
key_file2=$4
BINPATH=/home/akhil/matching_v0.0.1/bin/match_pairs
SIFT=/home/akhil/matching_v0.0.1/bin/sift

pgm_file=`echo $IMAGE1 | sed 's/jpg$/pgm/'`
key_file=`echo $IMAGE1 | sed 's/jpg$/key/'`
gzipped_key_file=$key_file1".gz"

if [ -f $key_file1 ]; 
then
  echo "Sorting exisiting key file " $key_file1
  ./key_sorter.sh $key_file1;
elif [ -f $gzipped_key_file ]; 
then
  echo "Found gzipped key, uncompressing and sorting --" $gzipped_key_file
  gunzip $gzipped_key_file 
  ./key_sorter.sh $key_file1;
else
  mogrify -format pgm $IMAGE1
  $SIFT < $pgm_file > $key_file1 
  rm $pgm_file
fi

echo --source_image=$IMAGE1 > options.txt
echo --source_key=$key_file1 >> options.txt
echo --source_dimension=`identify $IMAGE1 | cut -d' ' -f3` >> options.txt

pgm_file=`echo $IMAGE2 | sed 's/jpg$/pgm/'`
key_file=`echo $IMAGE2 | sed 's/jpg$/key/'`
gzipped_key_file=$key_file2".gz"

if [ -f $key_file2 ]; 
then
  echo "Sorting exisiting key file " $key_file2
 ./key_sorter.sh $key_file2;
elif [ -f $gzipped_key_file ]; 
then
  echo "Found gzipped key, sorting exisiting gzipped key file" $gzipped_key_file
  gunzip $gzipped_key_file 
 ./key_sorter.sh $key_file2;
  gzip -f $key_file2
else
  mogrify -format pgm $IMAGE2; 
  $SIFT < $pgm_file > $key_file2; 
  rm $pgm_file
fi

echo --target_image=$IMAGE2 >> options.txt
echo --target_key=$key_file2 >> options.txt
echo --target_dimension=`identify $IMAGE2 | cut -d' ' -f3` >> options.txt
#changing
#echo "--result_path=../results/" >> options.txt
echo --result_path=$RESULT >> options.txt
#echo "--visualize" >> options.txt
#echo "--save_visualization" >> options.txt

$BINPATH --options_file=options.txt
