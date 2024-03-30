# while true; do
#     BATT=$(cat /sys/class/power_supply/BAT0/capacity)
#     XDISP="Bat: $BATT% Date: `date` Uptime: `uptime | sed 's/.*,//'`"
#     xsetroot -name "$XDISP"
#     sleep 1
# done &
# exec dwm
exec i3
