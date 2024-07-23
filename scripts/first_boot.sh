#!/bin/bash

#------------------------------------------------------------------------------
# Load Environment Variables
#------------------------------------------------------------------------------

source "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars_extended.sh"
source "$ZYNTHIAN_SYS_DIR/scripts/delayed_action_flags.sh"

#------------------------------------------------------------------------------

# Hardware Autoconfig
echo -e "\nRunning autoconfig..." >> /root/first_boot.log
$ZYNTHIAN_SYS_DIR/sbin/zynthian_autoconfig.py 2>&1 >> /root/first_boot.log
if [ -f $REBOOT_FLAGFILE ]; then
	clean_all_flags
	echo -e "\nReboot..." >> /root/first_boot.log
	sync
	reboot -f
	exit
fi

# Fix ALSA mixer settings
echo -e "\nFixing ALSA mixer settings..." >> /root/first_boot.log
$ZYNTHIAN_SYS_DIR/sbin/fix_alsamixer_settings.sh 2>&1 >> /root/first_boot.log

# Regenerate Keys
echo -e "\nRegenerating keys..." >> /root/first_boot.log
$ZYNTHIAN_SYS_DIR/sbin/regenerate_keys.sh 2>&1 >> /root/first_boot.log

# Regenerate cache LV2 if needed
cd $ZYNTHIAN_CONFIG_DIR/jalv
if [[ "$(ls -1q | wc -l)" -lt 20 ]]; then
	echo -e "Regenerating LV2 cache..." >> /root/first_boot.log
	cd $ZYNTHIAN_UI_DIR/zyngine
	python3 ./zynthian_lv2.py
fi

# Disable first_boot service
systemctl disable first_boot

# Resize partition & reboot
echo -e "Resizing partition..." >> /root/first_boot.log
raspi-config --expand-rootfs

# Reboot
reboot