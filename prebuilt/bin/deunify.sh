#!/sbin/sh
baseband="";
for e in $(cat /proc/cmdline);
do
    tmp=$(echo $e | grep "androidboot.baseband" > /dev/null);
    if [ "0" == "$?" ]; then
        baseband=$(echo $e |cut -d":" -f1 |cut -d"=" -f2);
    fi
done

# Move variant-specific blobs
mv /vendor/firmware/variant/$baseband/a506_zap* /vendor/firmware/
mv /vendor/firmware/variant/$baseband/goodixfp* /vendor/firmware/
rm -rf /vendor/firmware/variant

# Remove telephony files for wifi variant
if [ "$baseband" == "apq" ]; then 
    rm -rf /system/app/datastatusnotification
    rm -rf /system/app/messaging
    rm -rf /system/app/QtiTelephonyService
    rm -rf /system/app/SecureElement
    rm -rf /system/app/SimAppDialog
    rm -rf /system/app/Stk
    rm -rf /system/priv-app/CarrierConfig
    rm -rf /system/priv-app/CellBroadcastReceiver
    rm -rf /system/priv-app/Dialer
    rm -rf /system/priv-app/Telecom
    rm -rf /system/priv-app/TelephonyProvider
    rm -rf /system/priv-app/TeleService
fi
