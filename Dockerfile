FROM centos:8
MAINTAINER Eric Franz <efranz@osc.edu>

RUN dnf update -y && dnf clean all && rm -rf /var/cache/dnf/*
RUN dnf install -y \
        dnf-utils \
        epel-release \
    && dnf config-manager --set-enabled powertools \
    && dnf clean all && rm -rf /var/cache/dnf/*
RUN dnf install -y \
        R R-devel R-Rcpp R-Rcpp-devel gdal gdal-devel \
    && dnf clean all && rm -rf /var/cache/dnf/*
RUN dnf install -y \
        curl-devel openssl-devel libxml2-devel libjpeg-turbo-devel \
        udunits2-devel cairo-devel proj-devel sqlite-devel geos-devel \
        && dnf clean all && rm -rf /var/cache/dnf/*

RUN mkdir -p /opt/covid
COPY passenger-setup.sh /opt/covid/passenger-setup.sh
RUN /opt/covid/passenger-setup.sh

COPY install_packages_or_die.R /
RUN Rscript --no-save /install_packages_or_die.R DT
RUN Rscript --no-save /install_packages_or_die.R EpiEstim
RUN Rscript --no-save /install_packages_or_die.R RColorBrewer
RUN Rscript --no-save /install_packages_or_die.R collapse
RUN Rscript --no-save /install_packages_or_die.R ggplot2
RUN Rscript --no-save /install_packages_or_die.R ggtext
RUN Rscript --no-save /install_packages_or_die.R ggthemes
RUN Rscript --no-save /install_packages_or_die.R heatmaply
RUN Rscript --no-save /install_packages_or_die.R htmltools
RUN Rscript --no-save /install_packages_or_die.R htmlwidgets
RUN Rscript --no-save /install_packages_or_die.R lattice
RUN Rscript --no-save /install_packages_or_die.R leaflet
RUN Rscript --no-save /install_packages_or_die.R lubridate
RUN Rscript --no-save /install_packages_or_die.R maptools
RUN Rscript --no-save /install_packages_or_die.R mgcv
RUN Rscript --no-save /install_packages_or_die.R plotly
RUN Rscript --no-save /install_packages_or_die.R purrr
RUN Rscript --no-save /install_packages_or_die.R qcc
RUN Rscript --no-save /install_packages_or_die.R raster
RUN Rscript --no-save /install_packages_or_die.R readxl
RUN Rscript --no-save /install_packages_or_die.R reshape2
RUN Rscript --no-save /install_packages_or_die.R shiny
RUN Rscript --no-save /install_packages_or_die.R shinyWidgets
RUN Rscript --no-save /install_packages_or_die.R shinydashboard
RUN Rscript --no-save /install_packages_or_die.R shinyjs
RUN Rscript --no-save /install_packages_or_die.R shinythemes
RUN Rscript --no-save /install_packages_or_die.R sp
RUN Rscript --no-save /install_packages_or_die.R tidyquant
RUN Rscript --no-save /install_packages_or_die.R tidyverse
RUN Rscript --no-save /install_packages_or_die.R zoo
RUN export DOWNLOAD_STATIC_LIBV8=1 ; Rscript --no-save /install_packages_or_die.R V8
RUN Rscript --no-save /install_packages_or_die.R units
RUN Rscript --no-save /install_packages_or_die.R gdtools
RUN Rscript --no-save /install_packages_or_die.R rgdal
RUN Rscript --no-save /install_packages_or_die.R rgeos
RUN Rscript --no-save /install_packages_or_die.R sf
RUN Rscript --no-save /install_packages_or_die.R svglite
RUN Rscript --no-save /install_packages_or_die.R leafpop
RUN Rscript --no-save /install_packages_or_die.R formattable
COPY start_shiny_app.R /opt/covid/start_shiny_app.R
COPY start_shiny_app /opt/covid/start_shiny_app

#
# to get R install command for installing R deps, checkout branch of covid app and run command
# rg library | rg 'library\((\w+)\)' -o -r '$1' | sort | uniq | ruby -e "puts 'install.packages(c(' + STDIN.read.split.map {|x| %Q('#{x}')}.join(',') + '))'"
# (where rg is ripgrep)
#
# or checkout both branches to creat intermediary file of all pkgs first
