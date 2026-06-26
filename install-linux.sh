#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GITCONFIG_INCLUDE="${DOTFILES_DIR}/git/gitconfig-psilon"
SHELL_RC="${HOME}/.bashrc"

info() {
  printf '==> %s\n' "$*"
}

link_path() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$(readlink "$dest")" == "$src" ]]; then
      info "already linked: $dest"
      return 0
    fi

    info "replacing: $dest"
    rm -rf "$dest"
  fi

  ln -sfn "$src" "$dest"
  info "linked $dest -> $src"
}

ensure_line() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -qF "$line" "$file"; then
    printf '\n%s\n' "$line" >>"$file"
    info "added to $(basename "$file"): $line"
  else
    info "already in $(basename "$file"): $line"
  fi
}

install_git() {
  if [[ -f "${HOME}/.gitconfig" ]]; then
    if git config --global --get-all include.path | grep -qF "$GITCONFIG_INCLUDE"; then
      info "git include.path already set: $GITCONFIG_INCLUDE"
    else
      git config --global --add include.path "$GITCONFIG_INCLUDE"
      info "added git include.path: $GITCONFIG_INCLUDE"
    fi
  else
    link_path "$GITCONFIG_INCLUDE" "${HOME}/.gitconfig"
  fi
}

install_shell() {
  ensure_line "$SHELL_RC" "# dotfiles"
  ensure_line "$SHELL_RC" "source \"${DOTFILES_DIR}/shell/shrc-psilon.sh\""
  ensure_line "$SHELL_RC" 'eval "$(starship init bash)"'
}

main() {
  info "installing dotfiles from ${DOTFILES_DIR}"

  link_path "${DOTFILES_DIR}/nvim" "${HOME}/.config/nvim"
  link_path "${DOTFILES_DIR}/tmux/tmux.conf" "${HOME}/.tmux.conf"
  link_path "${DOTFILES_DIR}/starship/starship.toml" "${HOME}/.config/starship.toml"

  install_git
  install_shell

  info "done"
  info "restart your shell or run: source ${SHELL_RC}"
}

main "$@"
