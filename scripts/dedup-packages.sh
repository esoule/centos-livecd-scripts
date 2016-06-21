#!/bin/bash
export LANG=C
export LC_ALL=C
export TZ=UTC
comm -1 -2 <(sort packages-desktop.ks | grep -v '^#') <(sort packages-plus.ks | grep -v '^#') >packages-common-desktop-plus~
comm -1 -2 packages-common-desktop-plus~  <(sort packages-devel.ks | grep -v '^#') >packages-common~

./dedup-select-lines.pl filter-in packages-common~  packages-desktop.ks
mv packages-desktop.ks.new~ packages-common.ks

./dedup-select-lines.pl filter-out packages-common~  packages-desktop.ks packages-plus.ks packages-devel.ks
