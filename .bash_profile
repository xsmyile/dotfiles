# Suppress shell warnings and set appearance
export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export LANG="en_US.UTF-8"
export TERMINFO_DIRS="${TERMINFO_DIRS:+$TERMINFO_DIRS:}$HOME/.local/share/terminfo"

# Prompt appearance
export PS1="\[\e[32m\]smyile@blackbird\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]$ "

# Default editor
export EDITOR="nvim"

# Compiler
export CC="/usr/bin/clang"

# Homebrew (inlined from: /opt/homebrew/bin/brew shellenv)
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_BUNDLE_FILE="$HOME/dotfiles/brew/Brewfile"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# Paths
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd --resolve-engines --log-level quiet --shell bash)"

# Aliases
alias vi="nvim"
alias ae="source .venv/bin/activate"
alias pipcs="pip-compile --no-annotate && pip-sync"
alias djrun="python manage.py runserver"
alias djmk="python manage.py makemigrations && echo '--- Migrations made ---' && python manage.py migrate"
alias lg="lazygit"
alias lk="lazydocker"

# Prevents Claude's auto-updater from running.
# Using an alias instead of exporting globally to avoid breaking other tools
# that might rely on DISABLED_AUTOUPDATER.
alias claude="DISABLED_AUTOUPDATER=1 claude"

# uv global Python
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

# pipx binaries
[[ ":$PATH:" != *":$HOME/.local/pipx/bin:"* ]] && export PATH="$HOME/.local/pipx/bin:$PATH"
. "$HOME/.cargo/env"
