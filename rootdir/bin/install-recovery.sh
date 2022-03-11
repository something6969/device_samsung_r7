#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:b4dc326360375808a30cfe6de933cf2b012df96c; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:efbb0c1036da36fd8b7c44cfad8a6d370b222f5a \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:b4dc326360375808a30cfe6de933cf2b012df96c && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

