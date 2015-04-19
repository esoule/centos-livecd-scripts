#!/bin/bash

if [ -z "$LIVE_ROOT" ] ; then
    echo "ERROR: LIVE_ROOT empty" >&2
    exit 1
fi

cp $LIVE_ROOT/isolinux/isolinux.cfg $LIVE_ROOT/isolinux/isolinux.cfg.orig

# customize boot menu entries
grep -B4 'menu default'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/default.txt
grep -B3 'xdriver=vesa'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/basicvideo.txt
grep -A3 'label check0'  $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/check.txt
grep -A2 'label memtest' $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/memtest.txt
grep -A2 'label local'   $LIVE_ROOT/isolinux/isolinux.cfg > $LIVE_ROOT/isolinux/localboot.txt

sed "s/label linux0/label linuxtext0/"   $LIVE_ROOT/isolinux/default.txt > $LIVE_ROOT/isolinux/textboot.txt
sed -i "s/Boot/Boot (Text Mode)/"                                           $LIVE_ROOT/isolinux/textboot.txt
sed -i "s/liveimg/liveimg 3/"                                               $LIVE_ROOT/isolinux/textboot.txt
sed -i "/menu default/d"                                                    $LIVE_ROOT/isolinux/textboot.txt

sed "s/label linux0/label install0/"     $LIVE_ROOT/isolinux/default.txt > $LIVE_ROOT/isolinux/install.txt
sed -i "s/Boot/Install/"                                                    $LIVE_ROOT/isolinux/install.txt
sed -i "s/liveimg/liveimg liveinst noswap nolvmmount/"                      $LIVE_ROOT/isolinux/install.txt
sed -i "s/ quiet / /"                                                       $LIVE_ROOT/isolinux/install.txt
sed -i "s/ rhgb / /"                                                        $LIVE_ROOT/isolinux/install.txt
sed -i "/menu default/d"                                                    $LIVE_ROOT/isolinux/install.txt

sed "s/label linux0/label textinstall0/" $LIVE_ROOT/isolinux/default.txt > $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/Boot/Install (Text Mode)/"                                        $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/liveimg/liveimg textinst noswap nolvmmount/"                      $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/ quiet / /"                                                       $LIVE_ROOT/isolinux/textinstall.txt
sed -i "s/ rhgb / /"                                                        $LIVE_ROOT/isolinux/textinstall.txt
sed -i "/menu default/d"                                                    $LIVE_ROOT/isolinux/textinstall.txt

cat $LIVE_ROOT/isolinux/default.txt $LIVE_ROOT/isolinux/basicvideo.txt $LIVE_ROOT/isolinux/check.txt $LIVE_ROOT/isolinux/memtest.txt $LIVE_ROOT/isolinux/localboot.txt > $LIVE_ROOT/isolinux/current.txt
diff $LIVE_ROOT/isolinux/isolinux.cfg $LIVE_ROOT/isolinux/current.txt | sed '/^[0-9][0-9]*/d; s/^. //; /^---$/d' > $LIVE_ROOT/isolinux/cleaned.txt
cat $LIVE_ROOT/isolinux/cleaned.txt $LIVE_ROOT/isolinux/default.txt $LIVE_ROOT/isolinux/textboot.txt $LIVE_ROOT/isolinux/basicvideo.txt $LIVE_ROOT/isolinux/install.txt $LIVE_ROOT/isolinux/textinstall.txt $LIVE_ROOT/isolinux/memtest.txt $LIVE_ROOT/isolinux/localboot.txt > $LIVE_ROOT/isolinux/isolinux.cfg
rm -f $LIVE_ROOT/isolinux/*.txt

# Forcing plymouth to show the logo in vesafb 
sed -i "s/rhgb/rhgb vga=791/g"	$LIVE_ROOT/isolinux/isolinux.cfg

# Disabling auto lvm/disk mount (that will crash the "Install to Hard Drive feature")
sed -i "s/quiet/quiet nodiskmount nolvmmount/g"	$LIVE_ROOT/isolinux/isolinux.cfg

