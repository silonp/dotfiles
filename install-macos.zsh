#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_DIR="${0:A:h}"
SHELL_RC="${HOME}/.zshrc"
STARSHIP_SHELL="zsh"

source "${DOTFILES_DIR}/install-common.sh"

main() {
    log_header "Installing from ${DOTFILES_DIR}"

    install_common_links
    link_path "${DOTFILES_DIR}/wezterm/wezterm.lua" "${HOME}/.wezterm.lua"
    install_git
    install_shell
    finish_install
}

main "$@"
