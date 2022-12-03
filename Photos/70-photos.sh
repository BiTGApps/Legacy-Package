#!/sbin/sh
#
# This file is part of The BiTGApps Project

# ADDOND_VERSION=3

if [ -z "$backuptool_ab" ]; then
  SYS="$S"
  TMP=/tmp
else
  SYS="/postinstall/system"
  TMP="/postinstall/tmp"
fi

. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/Photos/Photos.apk
app/Photos/split_config.en.apk
app/Photos/split_config.xhdpi.apk
app/Photos/lib/arm/libcronet.107.0.5284.2.so
app/Photos/lib/arm/libfilterframework_jni.so
app/Photos/lib/arm/libflacJNI.so
app/Photos/lib/arm/libframesequence.so
app/Photos/lib/arm/libnative_crash_handler_jni.so
app/Photos/lib/arm/libnative.so
app/Photos/lib/arm/liboliveoil.so
app/Photos/lib/arm/libwebp_android.so
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
    for i in $(list_files); do
      chown root:root "$SYS/$i" 2>/dev/null
      chmod 644 "$SYS/$i" 2>/dev/null
      chmod 755 "$(dirname "$SYS/$i")" 2>/dev/null
    done
  ;;
esac
