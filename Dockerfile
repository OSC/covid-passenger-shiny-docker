FROM centos:7
MAINTAINER Eric Franz <efranz@osc.edu>

RUN yum update -y && yum clean all && rm -rf /var/cache/yum/*
RUN yum install -y \
        yum-utils \
        epel-release \
        # https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum-config-manager --enable epel && yum update -y && yum clean all && rm -rf /var/cache/yum/*
RUN yum install -y \
        gcc glibc glibc-common gd gd-devel gcc-c++ lapack-devel make file readline-devel \
        gcc-gfortran zlib-devel bzip2-devel pcre-devel curl-devel xz-devel \
        which qpdf valgrind-devel java-1.8.0-openjdk-devel openssl-devel libxml2-devel \
        cairo-devel v8-devel udunits2-devel proj proj-devel proj-epsg proj-nad geos geos-devel \
        openblas-devel libXt-devel libXmu-devel libX11-devel less autoconf automake ncurses-devel libtool \
        pango-devel pango libpng-devel libtiff-devel libjpeg-turbo-devel libicu-devel bzip2-devel \
    && yum clean all && rm -rf /var/cache/yum/*

RUN mkdir -p /opt/covid
COPY passenger-setup.sh /opt/covid/passenger-setup.sh
RUN /opt/covid/passenger-setup.sh
COPY gdal-setup.sh /opt/covid/gdal-setup.sh
RUN /opt/covid/gdal-setup.sh

COPY r-setup.sh /opt/covid/r-setup.sh
RUN /opt/covid/r-setup.sh
RUN Rscript -e "install.packages(c('DT'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('EpiEstim'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('RColorBrewer'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('collapse'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('ggplot2'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('ggtext'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('ggthemes'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('heatmaply'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('htmltools'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('htmlwidgets'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('lattice'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('leaflet'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('lubridate'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('maptools'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('mgcv'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('plotly'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('purrr'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('qcc'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('raster'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('readxl'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('reshape2'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('shiny'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('shinyWidgets'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('shinydashboard'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('shinyjs'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('shinythemes'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('sp'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('tidyquant'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('tidyverse'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('zoo'), repos='https://cran.case.edu/')"
# foreign
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV LIBRARY_PATH=/usr/local/lib
ENV INCLUDE=/usr/local/include
ENV CPATH=/usr/local/include
ENV FPATH=/usr/local/include
ENV PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
RUN Rscript -e "install.packages(c('V8'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('units'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('gdtools'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('rgdal'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('rgeos'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('sf'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('svglite'), repos='https://cran.case.edu/')"
RUN Rscript -e "install.packages(c('leafpop'), repos='https://cran.case.edu/')"
COPY shiny_app_env /opt/covid/shiny_app_env
COPY start_shiny_app.R /opt/covid/start_shiny_app.R
COPY start_shiny_app /opt/covid/start_shiny_app

#
# to get R install command for installing R deps, checkout branch of covid app and run command
# rg library | rg 'library\((\w+)\)' -o -r '$1' | sort | uniq | ruby -e "puts 'install.packages(c(' + STDIN.read.split.map {|x| %Q('#{x}')}.join(',') + '))'"
# (where rg is ripgrep)
#
# or checkout both branches to creat intermediary file of all pkgs first
