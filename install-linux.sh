#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHELL_RC="${HOME}/.bashrc"
STARSHIP_SHELL="bash"

source "${DOTFILES_DIR}/install-common.sh"

main() {
    log_header "Installing from ${DOTFILES_DIR}"

    install_common_links
    install_git
    install_shell
    finish_install
}

main "$@"
