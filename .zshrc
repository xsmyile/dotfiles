# --- Appearance / Environment ---
export XDG_CONFIG_HOME="$HOME/.config"
export CLICOLOR=1
export LANG="en_US.UTF-8"
export TERMINFO_DIRS="${TERMINFO_DIRS:+$TERMINFO_DIRS:}$HOME/.local/share/terminfo"

# --- vcs_info setup for git branch ---
autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:git:*' formats ' %F{158}(󰘬 %b)%f'
add-zsh-hook precmd vcs_info

# --- Prompt ---
setopt PROMPT_SUBST
PROMPT='%F{153}smyile@blackbird%f%F{224} %~%f${vcs_info_msg_0_} %F{153}❯%f '

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
fpath[1,0]="/opt/homebrew/share/zsh/site-functions"

# Paths
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd --resolve-engines --log-level quiet --shell zsh)"

# Custom completions (pnpm, Docker) -- must be set before zinit/zsh-autocomplete calls compinit
fpath=($HOME/.zsh/completions $HOME/.docker/completions $fpath)

# Zinit and plugins
if [[ -f /opt/homebrew/opt/zinit/zinit.zsh ]]; then
  source /opt/homebrew/opt/zinit/zinit.zsh

  # zsh-autocomplete must load eagerly (incompatible with turbo mode)
  zstyle ':autocomplete:*' delay 0.15
  zstyle ':autocomplete:*' timeout 3.0
  zstyle ':autocomplete:*' min-input 2
  zinit light marlonrichert/zsh-autocomplete

  # Turbo-loaded plugins (deferred after first prompt)
  zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    g-plane/pnpm-shell-completion \
    atinit"zicompinit; zicdreplay" \
    atload'[[ -f ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh ]] && source ~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh; eval "$(fnm completions --shell zsh)"' \
      zsh-users/zsh-syntax-highlighting
fi

# --- Aliases ---
alias vi="nvim"
alias ae="source .venv/bin/activate"
alias djrun="python manage.py runserver"
alias djmm="python manage.py makemigrations && echo '--- Migrations made ---' && python manage.py migrate"
alias lg="lazygit"
alias lk="lazydocker"
alias cl="claude --dangerously-skip-permissions"

path_add() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH";;
  esac
}

# uv global Python
path_add "$HOME/.local/bin"

# pipx binaries
path_add "$HOME/.local/pipx/bin"
. "$HOME/export-esp.sh"
