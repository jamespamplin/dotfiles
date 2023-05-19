source ~/.config/fish/aliases.fish

# For signing commits
set -x GPG_TTY (tty)

# Starship theme - https://github.com/starship/starship
starship init fish | source
