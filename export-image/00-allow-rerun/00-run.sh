#!/bin/bash -e
# ==============================================================================
# Allow-Rerun Process for export_image stage of FusionOS Build
# ==============================================================================
# Modification History:
#   28-Aug-2018 <jwa> - Added some diagnostic and progress output to help 
#       follow the process.
# 
#===============================================================================

#-<jwa>-----------------------------------------------
# Let's include a little color into the output using
# VT100 (TTY) Substitutions
ESC=
COL60=$ESC[60G

# Attributes    ;    Foregrounds     ;    Backgrounds
atRST=$ESC[0m   ;   fgBLK=$ESC[30m   ;   bgBLK=$ESC[40m
atBRT=$ESC[1m   ;   fgRED=$ESC[31m   ;   bgRED=$ESC[41m
atDIM=$ESC[2m   ;   fgGRN=$ESC[32m   ;   bgGRN=$ESC[42m
atUN1=$ESC[3m   ;   fgYEL=$ESC[33m   ;   bgYEL=$ESC[43m
atUND=$ESC[4m   ;   fgBLU=$ESC[34m   ;   bgBLU=$ESC[44m
atBLK=$ESC[5m   ;   fgMAG=$ESC[35m   ;   bgMAG=$ESC[45m
atUN2=$ESC[6m   ;   fgCYN=$ESC[36m   ;   bgCYN=$ESC[46m
atREV=$ESC[7m   ;   fgWHT=$ESC[37m   ;   bgWHT=$ESC[47m
atHID=$ESC[8m   ;   fgNEU=$ESC[39m   ;   bgNEU=$ESC[49m


#---[ Beginning of allow-rerun processing ]-----------------------------------------------
echo "$atBRT$fgCYN***** Processing Allow-Rerun *****$atRST$fgNEU"

if [ -e ${ROOTFS_DIR}/etc/ld.so.preload ]; then
	mv ${ROOTFS_DIR}/etc/ld.so.preload ${ROOTFS_DIR}/etc/ld.so.preload.disabled
fi

if [ ! -e ${ROOTFS_DIR}/usr/sbin/policy-rc.d ]; then
	install -m 744 files/policy-rc.d ${ROOTFS_DIR}/usr/sbin/
fi

if [ ! -x ${ROOTFS_DIR}/usr/bin/qemu-arm-static ]; then
	cp /usr/bin/qemu-arm-static ${ROOTFS_DIR}/usr/bin/
fi
