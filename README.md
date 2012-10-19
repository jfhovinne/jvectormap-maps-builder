jvectormap-maps-builder
=======================

This script builds jVectorMap countries maps from shapefiles, using the converter.py script.

Shapefiles files (i.e. dbf, shp and shx) must be available in a sub-folder
under the source folder, e.g. source/ne_10m_admin_0_countries/ne_10m_admin_0_countries.shp.

The source files must follow the `<map type>/<map type>.<ext>` format.

Maps files will be saved in a sub-folder under 'maps', test files in a sub-folder under 'tests'.

Use e.g. Quantum GIS to find out the indexes in the attribute tables.
