#!/usr/bin/env bash

set -euo pipefail

# Kawaii colored output (◕‿◕)
success() { echo -e "\033[32m(◕‿◕)♡\033[0m $* desu~"; }
error() { echo -e "\033[31m(╥﹏╥)\033[0m $* failed... gomen nasai" >&2; }
info() { echo -e "\033[34m(｡◕‿◕｡)\033[0m $* nya~"; }

# Check dependencies
command -v stow >/dev/null || { error "stow not found"; exit 1; }

# Determine targets based on OS
case "$(uname)" in
    Darwin) targets=(common unix macos) ;;
    Linux)  targets=(common unix linux) ;;
    *)      error "Unsupported OS: $(uname)"; exit 1 ;;
esac

info "Deploying dotfiles"

# Deploy function
deploy() {
    local target="$1"
    [[ -d "$target" ]] || return 1
    
    stow --dotfiles -D "$target" -t "$HOME" 2>/dev/null || true
    stow --dotfiles --adopt "$target" --ignore="YukiConfig.code-profile" -t "$HOME"
}

# Main deployment loop
cd "$(dirname "$0")" || exit 1
failed=()

for target in "${targets[@]}"; do
    if deploy "$target"; then
        success "$target complete!"
    else
        error "$target"
        failed+=("$target")
    fi
done

# Summary
if [[ ${#failed[@]} -eq 0 ]]; then
    success "Mission complete! Ciallo ～(∠・ω< )⌒★"
else
    error "Some configs"
    exit 1
fi
