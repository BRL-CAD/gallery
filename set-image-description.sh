#!/bin/bash
# Set the description for each image.
#
# Requires 'exiftool'.
# In ubuntu it can be installed with:
#     apt install libimage-exiftool-perl

find images -name '*.txt' \
  | while read file_txt; do
      #echo "$file_txt"
      f=${file_txt%%.txt}
      img_file=$(ls "${f}".[^t][^x][^t]* | grep -v '_original')
      [[ -z $img_file ]] && continue
      echo "$img_file"
      descr="$(cat "$file_txt")"
      [[ -z $descr ]] && continue
      exiftool -preserve -ImageDescription="$descr" "$img_file"
    done

# cleanup backup files
find images -name '*_original' -delete
