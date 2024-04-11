#!/bin/bash

# zynia 2024-04-10 Skip set_first_boot 
exit 0

# Stop zynthian services
if [[ "$VIRTUALIZATION" == "none" ]]; then
	echo "Stopping zynthian services..."
	systemctl stop zynthian
	systemctl stop zynthian-webconf
fi

# Clean unneeded packages & apt cache
echo "Cleaning unused packages and cache..."
apt -y autoremove
apt clean

# Delete configured wifi networks
clean_wifi_networks.sh

# Delete logs
echo "Deleting first boot logs..."
rm -f /root/first_boot.log
echo "Deleting system logs..."
for f in /var/log/* /var/log/**/* ; do
	if [ -f "$f" ]; then
		cat /dev/null > "$f"
	fi
done

# Removing user data files
echo "Removing user data files..."
rm -f $ZYNTHIAN_MY_DATA_DIR/snapshots/last_state.zss
rm -rf $ZYNTHIAN_MY_DATA_DIR/preset_favorites/*

# Restore factory config
echo "Restoring factory config..."
cp -a "$ZYNTHIAN_SYS_DIR/scripts/zynthian_envars.sh" $ZYNTHIAN_CONFIG_DIR
cp -a "$ZYNTHIAN_SYS_DIR/config/default_midi_profile.sh" "$ZYNTHIAN_CONFIG_DIR/midi-profiles/default.sh"
source $ZYNTHIAN_CONFIG_DIR/zynthian_envars.sh
update_zynthian_sys.sh
rm -rf $ZYNTHIAN_DIR/zyncoder/build
$ZYNTHIAN_DIR/zyncoder/build.sh
rm -rf $ZYNTHIAN_CONFIG_DIR/img
#rm -rf $ZYNTHIAN_CONFIG_DIR/jalv/presets_*

# Add First Boot Script to /etc/rc.local
echo "Enabling first boot service..."
systemctl enable first_boot

# Clean history
echo "Cleaning shell history..."
rm -f /home/zyn/.bash_history*
rm -f /home/zyn/.history*
rm -f /root/.bash_history*
rm -f /root/.python_history
rm -f /root/.history
history -c && history -w

# Message
echo "The system is going to halt. Extract the SD card and dump the image."
sleep 3
sync

# Power Off
poweroff
