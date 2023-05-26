source ~/.config/fish/aliases.fish

# For signing commits
set -x GPG_TTY (tty)

# Starship theme - https://github.com/starship/starship
starship init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
