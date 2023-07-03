#!/bin/sh

# custom
protocol=6  # 1 Android Phone 2 Android Watch 3 MacOS 4 企点 5 iPad 6 Android Pad
sim="T-Mobile"
sim_info="T-Mobile"
os_type="android"
apn="wifi"
vendor_os_name="android"

# user shell (termux etc.)
product=$(getprop ro.product.name)
device=$(getprop ro.product.device)
board=$(getprop ro.product.board)
brand=$(getprop ro.product.brand)
model=$(getprop ro.product.model)
boot_id=$(cat /proc/sys/kernel/random/boot_id)
proc_version=$(cat /proc/version)
mac_address=$(cat /sys/class/net/wlan0/address)
# mac_address=$(ip addr show wlan0 | awk '/ether/{print $2}')
ip_address=$(curl -s https://api.ipify.org)
ip_address_1=$(echo $ip_address | cut -d '.' -f 1)
ip_address_2=$(echo $ip_address | cut -d '.' -f 2)
ip_address_3=$(echo $ip_address | cut -d '.' -f 3)
ip_address_4=$(echo $ip_address | cut -d '.' -f 4)
# ip_address=$(ip addr show wlan0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
incremental=$(getprop ro.build.version.incremental)
display=$(getprop ro.build.display.id)
finger_print=$(getprop ro.build.fingerprint)
baseband=$(getprop gsm.version.baseband)
bootloader=$(getprop ro.bootloader)
version_incremental=$(getprop ro.build.version.incremental)
version_release=$(getprop ro.build.version.release)
version_codename=$(getprop ro.build.version.codename)
version_sdk=$(getprop ro.build.version.sdk)
vendor_name=$brand

# adb shell
wifi_ssid=$(dumpsys wifi | grep "current SSID"|cut -d '"' -f2)
android_id=$(settings get secure android_id)
wifi_bssid=$(dumpsys wifi | grep "BSSID" | grep "$wifi_ssid" | awk -F 'BSSID: ' '{print $2}' | awk -F ', ' '{print $1}' | sed '/^$/d' | grep -v false)
# apn=$(settings get global captive_portal_mode)

# random
# imei="043531087285758"                      # 示例（15 位数）
# imsi_md5="a8e3e5ddf99ae6af9c501a255ad765d5" # 示例 MD5
imei=$(head /dev/urandom | tr -dc '0-9' | fold -w 15 | head -n 1)
imsi_md5=$(head /dev/urandom | md5sum | awk '{print $1}')

json_data=$(cat <<EOF
{
    "product": "$product",
    "device": "$device",
    "board": "$board",
    "brand": "$brand",
    "model": "$model",
    "wifi_ssid": "$wifi_ssid",
    "android_id": "$android_id",
    "boot_id": "$boot_id",
    "proc_version": "$proc_version",
    "mac_address": "$mac_address",
    "ip_address": [
        ${ip_address_1},
        ${ip_address_2},
        ${ip_address_3},
        ${ip_address_4}
    ],
    "imei": "$imei",
    "incremental": "$incremental",
    "protocol": $protocol,
    "display": "$display",
    "finger_print": "$finger_print",
    "baseband": "$baseband",
    "sim": "$sim",
    "sim_info": "$sim_info",
    "os_type": "$os_type",
    "bootloader": "$bootloader",
    "wifi_bssid": "$wifi_bssid",
    "apn": "$apn",
    "version": {
        "incremental": "$version_incremental",
        "release": "$version_release",
        "codename": "$version_codename",
        "sdk": $version_sdk
    },
    "imsi_md5": "$imsi_md5",
    "vendor_name": "$vendor_name",
    "vendor_os_name": "$vendor_os_name"
}
EOF
)

echo "$json_data" > device.json