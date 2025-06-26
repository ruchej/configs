from i3pystatus import Status
from i3pystatus.calendar.lightning import Lightning


status = Status()

status.register(
    "shell",
    command="",
    format="",  # Иконка вызова PCManFM
    color="#00BFFF",
    on_leftclick="kcalc",  # Действие при щелчке (открывает PCManFM)
)

status.register(
    "shell",
    command="",
    format="",  # Иконка вызова PCManFM
    color="#00BFFF",
    on_leftclick="pcmanfm",  # Действие при щелчке (открывает PCManFM)
)

status.register(
    "network",
    interface="enp3s0",
    format_up="",
    on_leftclick="nm-connection-editor",
)

status.register(
    "network", interface="wlp4s0", format_up="{essid} {quality:03.0f}%", format_down=""
)

status.register(
    "clock",
    format="%a %-d %b %X",
    on_leftclick="zenity --calendar"
)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("cpu_usage", format="cpu {usage:02}%")

status.register(
    "mem",
    format="mem {percent_used_mem}%",
    color="#ffffff",
)

status.register(
    "xkblayout",
    color="#ffffff",
)

status.register(
    "pulseaudio",
    format="♪{volume}",
)

status.register(
    "shell",
    command="",
    format="",  # Иконка вызова PCManFM
    color="#00BFFF",
    on_leftclick="pavucontrol",  # Действие при щелчке (открывает PCManFM)
)

status.run()
