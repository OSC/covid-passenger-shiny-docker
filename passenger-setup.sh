#!/bin/bash

set -xe
## Install Passenger

# Add YUM repository
curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

# Install Passenger
dnf install -y passenger
dnf clean all && rm -rf /var/cache/dnf/*

passenger-config validate-install
