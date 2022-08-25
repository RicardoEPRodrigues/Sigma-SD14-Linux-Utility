# Sigma SD14 Linux Utility

A small script that converts RAW files from Sigma SD14 camera to DNG format to be used in Darktable.

It includes a Darktable style to more easily start manipulating the files.

It makes use of [x3f_extract](https://github.com/Kalpanika/x3f).

## Instructions

1. Create a folder called `RAW` in the project folder and move/copy the RAW X3F files there.
2. Open a terminal and run `./GenerateDNGFiles.sh` in the project folder. Wait for the process to end.
3. You can now see a new folder called `DNG`. In it are the DNG version of the photos.
4. Open Darktable and include the DNG files. The photos will appear purple. 
5. Go to `lighttable > styles > import...` and select the `Sigma SD14 Profile.dtstyle` file.
6. Select all the photos, select the imported style, and click `apply`.

