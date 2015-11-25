# copyDirAndShrinkImages
This bash script copies a complete directory, including (non empty) subdirectories and resizes the images in these directories to max 2000x2000 pixels.

I created this script to improve the performance of the gallery directory for a gallery.

#Usage: 
```bash
copyDirAndShrinkImages.sh your-sourcedir your-targetdir
```
where 
* `your-sourcedir` must be an existing directorystructure
* `your-targetdir` must not exist

Afterwards, `your-targetdir` will contain a copy of the content of the `your-sourcedir` including the (non-empty) sub directories and files where the images are shrinked to max 2000x2000 pixels.
