#!/bin/bash

if [ -z "$LIVE_ROOT" ] ; then
    echo "ERROR: LIVE_ROOT empty" >&2
    exit 1
fi

cp $LIVE_ROOT/isolinux/isolinux.cfg $LIVE_ROOT/isolinux/isolinux.cfg.orig

# customize boot menu entries
sed -n '/^label linux0/q;p'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/header.txt
grep -B4 'menu default'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/default.txt
grep -B3 'xdriver=vesa'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/basicvideo.txt
grep -A3 'label check0'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/check.txt
grep -A2 'label memtest' $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/memtest.txt
grep -A2 'label local'   $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/localboot.txt

cp $LIVE_ROOT/isolinux/default.txt           $LIVE_ROOT/isolinux/linux0-boot.txt
sed -i "/menu default/d"                     $LIVE_ROOT/isolinux/linux0-boot.txt
cp $LIVE_ROOT/isolinux/linux0-boot.txt       $LIVE_ROOT/isolinux/textboot.txt
cp $LIVE_ROOT/isolinux/linux0-boot.txt       $LIVE_ROOT/isolinux/install.txt
cp $LIVE_ROOT/isolinux/linux0-boot.txt       $LIVE_ROOT/isolinux/textinstall.txt

sed -i "s/label linux0/label linuxtext0/"    $LIVE_ROOT/isolinux/textboot.txt
sed -i "s/Boot/Boot (Text Mode)/"            $LIVE_ROOT/isolinux/textboot.txt
sed -i "s/liveimg/liveimg 3/"                $LIVE_ROOT/isolinux/textboot.txt

sed -i "s/label linux0/label install0/"      $LIVE_ROOT/isolinux/install.txt
sed -i "s/Boot/Install/"                     $LIVE_ROOT/isolinux/install.txt
sed -i "s/liveimg/liveimg liveinst noswap nolvmmount/"        $LIVE_ROOT/isolinux/install.txt
sed -i "s/ quiet / /"                        $LIVE_ROOT/isolinux/install.txt
sed -i "s/ rhgb / /"                         $LIVE_ROOT/isolinux/install.txt

sed -i "s/label linux0/label textinstall0/"  $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/Boot/Install (Text Mode)/"         $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/liveimg/liveimg textinst noswap nolvmmount/"        $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/ quiet / /"                        $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/ rhgb / /"                         $LIVE_ROOT/isolinux/textinstall.txt

cat $LIVE_ROOT/isolinux/header.txt $LIVE_ROOT/isolinux/default.txt $LIVE_ROOT/isolinux/textboot.txt $LIVE_ROOT/isolinux/basicvideo.txt $LIVE_ROOT/isolinux/install.txt $LIVE_ROOT/isolinux/textinstall.txt $LIVE_ROOT/isolinux/memtest.txt $LIVE_ROOT/isolinux/localboot.txt > $LIVE_ROOT/isolinux/isolinux.cfg

# Set resolution in vesafb mode, do not show logo during boot
sed -i "s/ rhgb / vga=791 /g"	$LIVE_ROOT/isolinux/isolinux.cfg

# Disabling auto lvm/disk mount (that will crash the "Install to Hard Drive feature")
sed -i "s/quiet/quiet nodiskmount nolvmmount/g"	$LIVE_ROOT/isolinux/isolinux.cfg

rm -f $LIVE_ROOT/isolinux/*.txt
