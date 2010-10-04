#!/bin/bash

# Script for preparing OS Rasters for use with MapServer

# HOW TO USE
# 1. Create a directory for the data to live in (eg /var/data/os). Copy my process_data.sh file here.
# 2. Create the following subdirectories and copy the relevant .zip files from the Ordnance Survey into them.
# * mini_scale (eg /var/data/os/mini_scale) - copy the MiniScale zip file here
# * 250k (eg /var/data/os/250k) - copy the 1:250 000 Scale Colour Raster zip file here
# * vector_map_district (eg /var/data/os/vector_map_district) - copy the OS VectorMap™ District zip files here
# * streetview (eg /var/data/os/streetview) - copy the Street View zip files here.
# For each of the datasets this script copies the tif files (the raster imagery)
# and the tfw files (which contain the georeference information) into a ‘rasters’ directory. It then
# creates a tileindex, which provides a massive perfomance increase to MapServer when dealing with
# large numbers of raster files in a single layer.

#process miniscale rasters
cd mini_scale
mkdir rasters
cp MiniScale/data/MiniScale_\(with_relief1\)_R12.tif rasters
cp MiniScale/data/georeferencing\ files/TFW/*.tfw rasters
cd..
#run gdaltindex to build the mapserver tileindex
gdaltindex MiniScale.shp mini_scale/rasters/MiniScale_\(with_relief1\)_R12.tif 



# process 1:250k rasters
cd 250k
mkdir rasters
find . -type f -iname \*.tif -exec mv {} rasters \;
find . -type f -iname \*.TFW -exec mv {} rasters \;
cd ..
#run gdaltindex to build the mapserver tileindex
gdaltindex 1_250000_scale_raster.shp 250k/rasters/*.tif



#process the vector map district rasters
cd vector_map_district
mkdir rasters
# find . -type f -name \*.zip\* -exec unzip {} \;
find . -type f -iname \*.tif -exec mv {} rasters \;
find . -type f -iname \*.TFW -exec mv {} rasters \;
cd ..
#run gdaltindex to build the mapserver tileindex
gdaltindex vmd.shp vmd/rasters/*.tif



#process the streetview rasters
cd streetview
mkdir rasters
find . -type f -name \*.zip\* -exec unzip {} \;
find . -type f -iname \*.tif -exec mv {} rasters \;
find . -type f -iname \*.TFW -exec mv {} rasters \;
cd ..
#run gdaltindex to build the mapserver tileindex
gdaltindex streetview.shp streetview/rasters/*.tif
