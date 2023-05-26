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

# 1password cli plugins
if test -e $HOME/.config/op/plugins.sh
  source $HOME/.config/op/plugins.sh
end

# aws session functions
function aws-production
  set -l env (aws configure export-credentials --profile production --format env)
  eval $env
end

function aws-staging
  set -l env (aws configure export-credentials --profile staging --format env)
  eval $env
end
