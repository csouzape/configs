#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"

log_info() {
    printf '[INFO] %s\n' "$1"
}

log_error() {
    printf '[ERROR] %s\n' "$1" >&2
}

die() {
    log_error "$1"
    exit 1
}

install_zed() {
    local source="${REPO_DIR}/zed"
    local target="${CONFIG_DIR}/zed"

    [[ -d "$source" ]] || die "Zed configuration not found: $source"

    log_info "Installing Zed configuration..."

    mkdir -p "$target"

    cp -r "${source}/." "$target/"

    log_info "Zed configuration installed."
}

install_all() {
    install_zed

    # Add more configuration functions here.
    # install_kitty
    # install_hyprland
    # install_waybar
    # install_git
}

usage() {
    cat <<EOF
Usage: $0 [option]

Options:
  zed       Install Zed configuration
  all       Install all configurations
  help      Show this help message

Examples:
  $0 zed
  $0 all
EOF
}

main() {
    case "${1:-all}" in
        zed)
            install_zed
            ;;
        all)
            install_all
            ;;
        help|-h|--help)
            usage
            ;;
        *)
            usage
            exit 1
            ;;
    esac
}

main "$@"
