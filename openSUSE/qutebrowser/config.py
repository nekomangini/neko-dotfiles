# if you want to be able to change settings via the GUI and have them persist across restarts
config.load_autoconfig()
# if you prefer to manage all settings manually through the config.py file.
# config.load_autoconfig(False)

# Enable dark mode
c.colors.webpage.darkmode.enabled = True

# Hide the status bar
c.statusbar.show = "never"

# Hide the tab bar if only one tab is open
c.tabs.show = "multiple"

# When the tab bar is visible, show it on the top
c.tabs.position = "top"

# YT adblock
# c.content.blocking.enabled = True
# c.content.blocking.hosts.lists = [
#     "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
#     "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext",
# ]

# c.content.blocking.method = "both"

# Bind 'jk' to exit insert mode
config.bind('jk', 'mode-leave', mode='insert')

# Bind 'jk' to exit command mode
config.bind('jk', 'mode-leave', mode='command')

# wallpaper
c.url.start_pages = ["~/.config/qutebrowser/startpage/startpage.html"]
