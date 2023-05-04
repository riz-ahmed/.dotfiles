import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

c.colors.webpage.darkmode.enabled=True
c.fonts.default_size="15pt"
c.zoom.default=150
