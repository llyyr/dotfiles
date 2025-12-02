#!/bin/bash
set -euo pipefail

RULES_DIR="/etc/udev/rules.d"
mkdir -p "$RULES_DIR"

cat > "$RULES_DIR/30-amdgpu.rules" <<'EOF'
KERNEL=="card1", SUBSYSTEM=="drm", DRIVERS=="amdgpu", \
  ATTR{device/power_dpm_force_performance_level}="manual", \
  ATTR{device/pp_power_profile_mode}="1", \
  ATTR{device/hwmon/hwmon0/power1_cap}="170000000"
EOF

cat > "$RULES_DIR/98-brio-100.rules" <<'EOF'
ACTION=="add", SUBSYSTEM=="video4linux", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="094c", \
  RUN+="/bin/bash -c '/usr/bin/v4l2-ctl -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat=MJPG --set-parm=30 --set-ctrl=auto_exposure=1,exposure_time_absolute=555,white_balance_automatic=0,backlight_compensation=0 && /usr/bin/v4l2-ctl -d /dev/video0 --set-ctrl=white_balance_temperature=4000,gain=200'"
EOF

cat > "$RULES_DIR/99-ctl471.rules" <<'EOF'
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="0300", MODE="0666"
SUBSYSTEM=="usb", ATTRS{idVendor}=="056a", ATTRS{idProduct}=="0300", MODE="0666"
EOF

udevadm control --reload-rules
udevadm trigger
