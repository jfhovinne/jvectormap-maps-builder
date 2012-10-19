#!/bin/sh

# Generates jVectorMap maps from shapefiles.
# 
# Shapefiles files (i.e. dbf, shp and shx) must be available in a sub-folder
# under the source folder, e.g. source/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp
# Maps files will be saved in a sub-folder under 'maps', test files in a sub-folder under 'tests'.
# Use Quantum GIS to find out the indexes in the attribute tables.
# The source files must follow the <map type>/<map type>.<ext> format.

USAGE="Usage: build.sh <map type> <country name index> <country code index>\n\
Example: ./build.sh ne_10m_admin_0_countries 10 11\n\
Example: ./build.sh ne_10m_admin_1_states_provinces 4 0"

if [ $# -le 2 ]; then
  echo $USAGE
  exit 1
fi

MAP_TYPE=$1
COUNTRY_NAME_INDEX=$2
COUNTRY_CODE_INDEX=$3

rm -rf ../tests/$MAP_TYPE && rm -rf ../maps/$MAP_TYPE
mkdir -p ../tests/$MAP_TYPE && mkdir -p ../maps/$MAP_TYPE

while read code; do
  ISO_CODE="$code"
  python converter.py \
  --width 900 \
  --country_name_index $COUNTRY_NAME_INDEX \
  --country_code_index $COUNTRY_CODE_INDEX \
  --where "ADM0_A3='$ISO_CODE'" \
  ../source/$MAP_TYPE/$MAP_TYPE.shp \
  ../maps/$MAP_TYPE/${MAP_TYPE}_${ISO_CODE}.js
  
  cat testfile.html | sed "s/ISO_CODE/$ISO_CODE/g" | sed "s/MAP_TYPE/$MAP_TYPE/g" > ../tests/$MAP_TYPE/$MAP_TYPE_$ISO_CODE.html
done < iso-codes.txt
