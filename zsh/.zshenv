export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

ZDOTDIR=$XDG_CONFIG_HOME/zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.cargo/env"
