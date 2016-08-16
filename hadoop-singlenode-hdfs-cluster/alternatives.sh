#!/bin/sh

hadoop_bin_dir='/usr/local/hadoop/bin -type '

for each in $(find $hadoop_bin_dir f ! -name "*.*"); do
  name=$(basename $each)
  alternatives --install "/usr/bin/$name" "$name" "$each" 99999;
done
