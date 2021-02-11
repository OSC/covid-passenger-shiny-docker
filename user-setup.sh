#!/bin/bash

set -xe

## Add users (covidsim, covidsimdev, covid, coviddev)

# uid=33929(covid) gid=6697(PAS1788) groups=6697(PAS1788)
# uid=33930(coviddev) gid=6697(PAS1788) groups=6697(PAS1788)
# uid=33024(covidsim) gid=6493(PAS1694) groups=6493(PAS1694),6602(PZS1008),6603(accesscovidsim)
# uid=33031(covidsimdev) gid=6493(PAS1694) groups=6493(PAS1694),6604(accesscovidsimdev),6602(PZS1008)

groupadd -g 6697 PAS1788
useradd -g PAS1788 -u 33929 covid
useradd -g PAS1788 -u 33930 coviddev

groupadd -g 6493 PAS1694
groupadd -g 6602 PZS1008
groupadd -g 6603 accesscovidsim
groupadd -g 6604 accesscovidsimdev

useradd -g PAS1694 -u 33024 covidsim
useradd -g PAS1694 -u 33031 covidsimdev

usermod -aG accesscovidsim covidsim
usermod -aG accesscovidsimdev covidsimdev
usermod -aG PZS1008 covidsim
usermod -aG PZS1008 covidsimdev

# ??? do we need home dirs for these users???

