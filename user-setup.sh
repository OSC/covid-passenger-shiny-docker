#!/bin/bash

set -xe

## Add users (covidsim, covidsimdev, covid, coviddev, focalmap, focalmapdev)

# uid=33929(covid) gid=6697(PAS1788) groups=6697(PAS1788)
# uid=33930(coviddev) gid=6697(PAS1788) groups=6697(PAS1788)
# uid=33024(covidsim) gid=6493(PAS1694) groups=6493(PAS1694),6602(PZS1008),6603(accesscovidsim)
# uid=33031(covidsimdev) gid=6493(PAS1694) groups=6493(PAS1694),6604(accesscovidsimdev),6602(PZS1008)
# uid=36970(focalmap) gid=2925(PZS0523) groups=2925(PZS0523),7175(PDE0001),6393(duo)
# uid=36971(focalmapdev) gid=2925(PZS0523) groups=2925(PZS0523),6393(duo),7175(PDE0001)

groupadd -g 6697 PAS1788
groupadd -g 6493 PAS1694
groupadd -g 6602 PZS1008
groupadd -g 6603 accesscovidsim
groupadd -g 6604 accesscovidsimdev
groupadd -g 2925 PZS0523
groupadd -g 7175 PDE0001

useradd -g PAS1694 -u 33024 covidsim
useradd -g PAS1694 -u 33031 covidsimdev
useradd -g PZS0523 -u 36970 focalmap
useradd -g PZS0523 -u 36971 focalmapdev

usermod -aG accesscovidsim covidsim
usermod -aG accesscovidsimdev covidsimdev
usermod -aG PZS1008 covidsim
usermod -aG PZS1008 covidsimdev
usermod -aG PDE0001 focalmap
usermod -aG PDE0001 focalmapdev


# ??? do we need home dirs for these users???

