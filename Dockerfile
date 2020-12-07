FROM centos:7
MAINTAINER Eric Franz <efranz@osc.edu>

RUN yum update -y && yum clean all && rm -rf /var/cache/yum/*
RUN yum install -y \
        yum-utils \
        epel-release \
        # https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum-config-manager --enable epel && yum update -y && yum clean all && rm -rf /var/cache/yum/*

RUN mkdir -p /opt/covid
COPY passenger-setup.sh /opt/covid/passenger-setup.sh
RUN /opt/covid/passenger-setup.sh
RUN yum install -y \
       gcc glibc glibc-common gd gd-devel gcc-c++ lapack-devel
RUN yum install -y \
       make file readline-devel
COPY gdal-setup.sh /opt/covid/gdal-setup.sh
RUN /opt/covid/gdal-setup.sh
RUN yum install -y \
        gcc-gfortran zlib-devel bzip2-devel pcre-devel curl-devel xz-devel \
        which qpdf valgrind-devel java-1.8.0-openjdk-devel openssl-devel libxml2-devel \
        cairo-devel v8-devel udunits2-devel proj proj-devel proj-epsg proj-nad geos geos-devel \
        openblas-devel libXt-devel libXmu-devel libX11-devel less autoconf automake ncurses-devel libtool \
        pango-devel pango libpng-devel libtiff-devel libjpeg-turbo-devel libicu-devel bzip2-devel

COPY r-setup.sh /opt/covid/r-setup.sh
RUN /opt/covid/r-setup.sh
RUN Rscript -e "install.packages(c('DT','EpiEstim','RColorBrewer','collapse','ggplot2','ggthemes','heatmaply','htmltools','htmlwidgets','lattice','leaflet','lubridate','maptools','mgcv','plotly','purrr','qcc','raster','readxl','reshape2','shiny','shinyWidgets','shinydashboard','shinyjs','shinythemes','sp','tidyquant','tidyverse','zoo'), repos='https://cran.case.edu/')"
# foreign
RUN LD_LIBRARY_PATH=/usr/local/lib LIBRARY_PATH=/usr/local/lib INCLUDE=/usr/local/include CPATH=/usr/local/include FPATH=/usr/local/include PKG_CONFIG_PATH=/usr/local/lib/pkgconfig Rscript -e "install.packages(c('V8','units', 'gdtools', 'rgdal','rgeos', 'sf', 'svglite', 'leafpop'), repos='https://cran.case.edu/')"
COPY shiny_app_env /opt/covid/shiny_app_env
COPY start_shiny_app.R /opt/covid/start_shiny_app.R
COPY start_shiny_app /opt/covid/start_shiny_app

#
# to get R install command for installing R deps, checkout branch of covid app and run command
# rg library | rg 'library\((\w+)\)' -o -r '$1' | sort | uniq | ruby -e "puts 'install.packages(c(' + STDIN.read.split.map {|x| %Q('#{x}')}.join(',') + '))'"
# (where rg is ripgrep)
#
# or checkout both branches to creat intermediary file of all pkgs first
