yum-builddep R

mkdir -p /src/R
cd /src/R
curl -o R-3.6.3.tar.gz https://cran.rstudio.com/src/base/R-3/R-3.6.3.tar.gz
tar xzf R-3.6.3.tar.gz
cd R-3.6.3

./configure --enable-R-shlib --with-blas --with-lapack --with-readline=yes --enable-memory-profiling
make
make install

cd /src
rm -rf R

