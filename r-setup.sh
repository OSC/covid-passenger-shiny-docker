#!/bin/bash

set -e

dnf builddep -y R
dnf clean all && rm -rf /var/cache/dnf/*

mkdir -p /src/R
cd /src/R
curl -o R-3.6.3.tar.gz https://cran.rstudio.com/src/base/R-3/R-3.6.3.tar.gz
tar xzf R-3.6.3.tar.gz
cd R-3.6.3

./configure --enable-R-shlib --with-blas --with-lapack --with-readline=yes --enable-memory-profiling
make -j2
make -j2 install

cd /src
rm -rf R

