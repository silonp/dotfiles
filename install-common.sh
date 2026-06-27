# Shared dotfiles install helpers. Source from platform install scripts.

GITCONFIG_INCLUDE="${DOTFILES_DIR}/git/gitconfig-psilon"

_INSTALL_RESET='\033[0m'
_INSTALL_BOLD='\033[1m'
_INSTALL_GREEN='\033[1;38;2;184;187;38m'
_INSTALL_RED='\033[1;38;2;251;73;52m'
_INSTALL_YELLOW='\033[1;38;2;250;189;47m'
_INSTALL_AQUA='\033[1;38;2;131;165;152m'
_INSTALL_MUTED='\033[1;38;2;146;131;116m'

if [[ ! -t 2 ]]; then
    _INSTALL_RESET=''
    _INSTALL_BOLD=''
    _INSTALL_GREEN=''
    _INSTALL_RED=''
    _INSTALL_YELLOW=''
    _INSTALL_AQUA=''
    _INSTALL_MUTED=''
fi

_log() {
    local color="$1"
    local icon="$2"
    shift 2
    printf '%b%s %s%b\n' "$color" "$icon" "$*" "$_INSTALL_RESET" >&2
}

info() {
    _log "$_INSTALL_AQUA" "→" "$*"
}

log_ok() {
    _log "$_INSTALL_GREEN" "✓" "$*"
}

log_skip() {
    _log "$_INSTALL_YELLOW" "○" "$*"
}

log_remove() {
    _log "$_INSTALL_RED" "✗" "$*"
}

log_header() {
    printf '%b⚙ Dotfiles%b %s\n' "$_INSTALL_BOLD$_INSTALL_GREEN" "$_INSTALL_RESET" "$*" >&2
}

link_path() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [[ -e "$dest" || -L "$dest" ]]; then
        log_remove "Removing: $dest"
        rm -rf "$dest"
    fi

    ln -sfn "$src" "$dest"
    log_ok "Linked $dest → $src"
}

# Append a line to a file if it is not already present.
ensure_line() {
    local file="$1"
    local line="$2"

    touch "$file"
    if ! grep -qF -- "$line" "$file"; then
        printf '\n%s\n' "$line" >>"$file"
        log_ok "Added to $(basename "$file"): $line"
    else
        log_skip "Already in $(basename "$file"): $line"
    fi
}

# Set up git config: symlink gitconfig-psilon when ~/.gitconfig is missing,
# otherwise append an [include] block to the existing file. Writes directly
# to ~/.gitconfig (not via git config) to avoid circular includes.
install_git() {
    local gitconfig="${HOME}/.gitconfig"

    if [[ -e "$gitconfig" || -L "$gitconfig" ]]; then
        if [[ "$gitconfig" -ef "$GITCONFIG_INCLUDE" ]]; then
            log_skip "Git config already linked: $GITCONFIG_INCLUDE"
            return
        fi

        if grep -qF -- "$GITCONFIG_INCLUDE" "$gitconfig"; then
            log_skip "Git include.path already set: $GITCONFIG_INCLUDE"
        else
            printf '\n[include]\n    path = %s\n' "$GITCONFIG_INCLUDE" >>"$gitconfig"
            log_ok "Added git include.path: $GITCONFIG_INCLUDE"
        fi
    else
        link_path "$GITCONFIG_INCLUDE" "$gitconfig"
    fi
}

install_shell() {
    ensure_line "$SHELL_RC" "source \"${DOTFILES_DIR}/shell/shrc-psilon.sh\""
    ensure_line "$SHELL_RC" "eval \"\$(starship init ${STARSHIP_SHELL})\""
}

install_common_links() {
    link_path "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
    link_path "${DOTFILES_DIR}/tmux/tmux.conf" "${HOME}/.tmux.conf"
    link_path "${DOTFILES_DIR}/starship/starship.toml" "${HOME}/.config/starship.toml"
}

finish_install() {
    log_ok "Done"
    info "Restart your shell or run: source ${SHELL_RC}"
}
