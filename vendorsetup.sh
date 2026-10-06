#! /usr/bin/env bash
#
# by rsuntk
# Further edited by IsaacCodesStuff

DEVICE_PATH=device/samsung/a05m

echo "Starting vendorsetup.sh"

jdm_patches_exist=$(grep -q "USE_SAMSUNG_JDM_HAPTICS" bootable/recovery/minuitwrp/events.cpp; echo $?)
a
if [ $jdm_patches_exist != 0 ]; then
	patch -p1 --no-backup-if-mismatch < $DEVICE_PATH/patches/01*.patch
	patch -p1 --no-backup-if-mismatch < $DEVICE_PATH/patches/02*.patch
	echo "Patches applied."
else
	echo "Patches skipped. Already applied."
fi

FDEVICE="a05m"
#set -o xtrace

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    export TW_DEFAULT_LANGUAGE="en"
	export ALLOW_MISSING_DEPENDENCIES=true
 	export LC_ALL="C"

    export OF_MAINTAINER="IsaacCodesStuff"
	export FOX_BUILD_TYPE="Unofficial"
    export FOX_MAINTAINER_PATCH_VERSION="3"

    export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1
    export FOX_USE_NANO_EDITOR=1
 	export FOX_DELETE_MAGISK_ADDON=1
	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1
	export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_STATUS_H=42
    export OF_STATUS_INDENT_LEFT=50
    export OF_STATUS_INDENT_RIGHT=50
	export OF_USE_SYSTEM_FINGERPRINT=1
    export FOX_ENABLE_APP_MANAGER=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
    export FOX_USE_ZSTD_BINARY=1

		# let's see what are our build VARs
		if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
		  export | grep "FOX" >> $FOX_BUILD_LOG_FILE
		  export | grep "OF_" >> $FOX_BUILD_LOG_FILE
		  export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
		  export | grep "TW_" >> $FOX_BUILD_LOG_FILE
		fi
fi