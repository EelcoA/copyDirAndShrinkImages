#!/bin/bash
# ----------------------------------------------------------------------
# copyDirAndShrinkImages2.sh
# ----------------------------------------------------------------------
# Copies a directorie structure and reduces the size of images when
# they are larger than 2000 pixels
# 
# Be aware: empty directories are not copied/created
# 
# Usage: copyDirAndShrinkImages.sh <sourcedir> <targetdir>
#
#  where <sourcedir> must be an existing directorystructure
#        <targetdir> must not exist
#                    afterwards, <targetdir> will contain a copy of the
#                    content of the <sourcedir> including sub directories
#                    and files. The images will be shrinked till max
#                    2000x2000.
# ----------------------------------------------------------------------
#
# test if there are two arguments
#
echo "-------------------"
echo "Starting... $0"
if [ ! $# -eq 2 ]; then
  echo "Error: Call this with 2 arguments, a source and target directory." 1>&2
  echo " " 1>&2
  exit 1
fi

#
# set source and target variables
#
source=$1
target=$2
#
# test if source is an existing directory
#
if [ ! -d $source ]; then
  echo "Error: Source directory '$source' is not an existing directory"   1>&2
  echo " " 1>&2
  exit 2
fi
#
# test if the target is a non existing directory, to prevent overwriting
#
if [ -d $target ]; then
  echo "Error: Target directory '$target' already exists"   1>&2
  echo " " 1>&2
  exit 3
fi
#
# create the target directory, also a test if we have permission
#
echo "-------------------"
echo "Create dir $target"
echo "-------------------"
mkdir -p "$target"
if [ $? -ne 0 ]; then
  echo "Error: Target directory '$target' can not be created"   1>&2
  echo " " 1>&2
  exit 4
fi
#
# the lenght of the sourcepath is needed to remove if from the 
# filenames that find delivers us
#
sourceStringLength=${#source}
#
# find all files, considering carriage returns and loop through
#
find $source -type f -print0 | while IFS= read -r -d "" file; do
   newfile=$target/${file:$sourceStringLength}
#   echo "newfile = $newfile"
   filename=$(basename "$file")
#   echo "filename = $filename"
   newdir=$(dirname "$newfile")
#   echo "newdir = $newdir"
   if [ ! -d "$newdir" ]; then 
     echo "-------------------"
     echo "Create dir $newdir"
     echo "-------------------"
     mkdir -p "$newdir"    # -p to create parent dir if required
   fi
   mimetype=$(mimetype -b "$file")
#   echo "mimetype = $mimetype"
   if [ ${mimetype:0:5} == "image" ]; then 
      echo "Convert $filename to $newfile"
      convert "$file" -resize 2000x2000\>  "$newfile"
   else
      echo "Copy    $filename to $newfile"
      cp "$file" "$newfile"
   fi
done

echo "-------------------"
echo "Read with $0"
echo "-------------------"
