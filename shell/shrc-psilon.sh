# Include the local bin directory in the PATH.
if [ -d "${HOME}/.local/bin" ]; then
    case ":${PATH}:" in
        *":${HOME}/.local/bin:"*) ;;
        *) export PATH="${HOME}/.local/bin:${PATH}" ;;
    esac
fi

# Aliases.
alias ..="cd .."
alias ...="cd ../.."

alias ls="eza"
alias ll="eza -lah"
alias tree="eza --tree"

alias vim='nvim'

# Get the directory of this script.
if [ -n "${BASH_VERSION:-}" ]; then
    _shrc_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    _shrc_dir="$(cd "$(dirname "${(%):-%x}")" && pwd)"
fi
# Source the tmux.sh file.
if [ -f "${_shrc_dir}/../tmux/tmux.sh" ]; then
    source "${_shrc_dir}/../tmux/tmux.sh"
fi
