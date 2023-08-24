import dracula.draw

config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

default_editor = ["kitty", "-e", "lvim", "-f", "{file}"]

config.set('editor.command', default_editor)
config.bind('<Ctrl-Shift-l>', 'spawn --userscript qute-bitwarden')
