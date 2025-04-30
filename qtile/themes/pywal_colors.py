# ~/.config/qtile/themes/pywal_colors.py
colors = []
cache = '/home/nekomangini/.cache/wal/colors'

def load_colors(cache):
    global colors
    colors = []
    try:
        with open(cache, 'r') as file:
            for _ in range(16):  # Read all 16 colors
                color = file.readline().strip()
                if color:
                    colors.append(color)
        # Fallback if fewer than 16 colors
        while len(colors) < 16:
            colors.append('#ffffff')
    except (FileNotFoundError, IOError):
        # Default to a safe palette if cache is missing
        colors.extend([
            '#000000', '#ff0000', '#00ff00', '#ffff00',
            '#0000ff', '#ff00ff', '#00ffff', '#ffffff',
            '#888888', '#ff5555', '#55ff55', '#ffff55',
            '#5555ff', '#ff55ff', '#55ffff', '#cccccc'
        ])

# Load colors at startup
load_colors(cache)
