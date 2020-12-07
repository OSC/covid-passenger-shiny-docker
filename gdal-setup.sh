# yum-builddep gdal

## Install gdal
mkdir -p /src/gdal
cd /src/gdal
curl -o gdal-2.4.4.tar.gz https://download.osgeo.org/gdal/2.4.4/gdal-2.4.4.tar.gz
tar xzf gdal-2.4.4.tar.gz
cd gdal-2.4.4
./configure --disable-static
make
make install

cd /src
rm -rf gdal

