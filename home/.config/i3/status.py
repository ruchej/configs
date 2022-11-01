from i3pystatus import Status


status = Status()

status.register(
    "network",
    interface="enp3s0",
    format_up="",
    on_leftclick='nm-connection-editor',
)

status.register(
    "network",
    interface="wlp4s0",
    format_up="{essid} {quality:03.0f}%",
    format_down=""
)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register(
    "clock",
    format="%a %-d %b %X",
)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register(
    "cpu_usage",
    format = ' {usage:02}%'
)


# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register(
    "pulseaudio",
    color_unmuted = '#ffff00',
    color_muted = '#aa0500',
    format_muted = '',
    format = ' {volume}',
    vertical_bar_width = 1,
    vertical_bar_glyphs = ['  ', ' ', '']
)

status.register(
    "xkblayout",
    color = '#ffffff',
)



status.run()
