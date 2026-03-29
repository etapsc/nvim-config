#!/usr/bin/env bash
set -euo pipefail

# Install all prerequisites for this Neovim configuration.
# Supports: Ubuntu/Debian, Fedora/RHEL, Arch, macOS (Homebrew).

NVIM_MIN_VERSION="0.11"
NERD_FONT="JetBrainsMono"
NERD_FONT_VERSION="3.3.0"

# ── helpers ───────────────────────────────────────────────────────────

info()  { printf '\033[1;34m[info]\033[0m  %s\n' "$*"; }
ok()    { printf '\033[1;32m[ok]\033[0m    %s\n' "$*"; }
warn()  { printf '\033[1;33m[warn]\033[0m  %s\n' "$*"; }
error() { printf '\033[1;31m[error]\033[0m %s\n' "$*"; exit 1; }

has() { command -v "$1" &>/dev/null; }

# ── detect OS / package manager ───────────────────────────────────────

detect_pm() {
  if [[ "$OSTYPE" == darwin* ]]; then
    has brew || error "Homebrew not found. Install it first: https://brew.sh"
    PM=brew
  elif has apt-get; then
    PM=apt
  elif has dnf; then
    PM=dnf
  elif has pacman; then
    PM=pacman
  else
    error "Unsupported package manager. Install the dependencies manually (see README)."
  fi
}

# ── install system packages ───────────────────────────────────────────

install_packages() {
  info "Installing system packages via $PM ..."

  case $PM in
    brew)
      brew install git make unzip gcc ripgrep fd tree-sitter
      ;;
    apt)
      sudo apt-get update
      sudo apt-get install -y \
        git make unzip gcc ripgrep fd-find xclip curl python3-pip python3-venv
      # fd is packaged as fd-find on Debian/Ubuntu; create symlink if missing
      if ! has fd && has fdfind; then
        sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
      fi
      ;;
    dnf)
      sudo dnf install -y \
        git make unzip gcc ripgrep fd-find xclip curl python3-pip
      if ! has fd && has fdfind; then
        sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
      fi
      ;;
    pacman)
      sudo pacman -Syu --needed --noconfirm \
        git make unzip gcc ripgrep fd xclip curl python-pip
      ;;
  esac

  ok "System packages installed."
}

# ── Neovim ────────────────────────────────────────────────────────────

install_neovim() {
  # Check if already installed with sufficient version
  if has nvim; then
    local cur
    cur="$(nvim --version | head -1 | grep -oP '\d+\.\d+')"
    if ! awk "BEGIN{exit !($cur < $NVIM_MIN_VERSION)}"; then
      ok "Neovim $cur already installed."
      return
    fi
    warn "Neovim $cur found but >= $NVIM_MIN_VERSION is required. Upgrading ..."
  fi

  if [[ $PM == brew ]]; then
    brew install neovim
  elif [[ $PM == pacman ]]; then
    sudo pacman -Syu --needed --noconfirm neovim
  else
    # Distro repos are usually too old — install from GitHub releases
    info "Installing Neovim from GitHub releases ..."

    # Remove distro neovim first to avoid version conflicts
    case $PM in
      apt) sudo apt-get remove -y neovim neovim-runtime 2>/dev/null || true ;;
      dnf) sudo dnf remove -y neovim 2>/dev/null || true ;;
    esac

    local arch
    arch="$(uname -m)"
    case "$arch" in
      x86_64)  arch="x86_64" ;;
      aarch64) arch="aarch64" ;;
      *) error "Unsupported architecture: $arch" ;;
    esac

    local url="https://github.com/neovim/neovim/releases/download/stable/nvim-linux-${arch}.tar.gz"
    local tmp
    tmp="$(mktemp -d)"

    curl -fsSL "$url" -o "$tmp/nvim.tar.gz"
    sudo rm -rf /opt/nvim
    sudo mkdir -p /opt/nvim
    sudo tar -xzf "$tmp/nvim.tar.gz" -C /opt/nvim --strip-components=1
    # Symlink to /usr/bin so it takes precedence everywhere
    sudo ln -sf /opt/nvim/bin/nvim /usr/bin/nvim
    rm -rf "$tmp"
  fi

  ok "Neovim $(nvim --version | head -1 | grep -oP '\d+\.\d+\.\d+') installed."
}

# ── tree-sitter CLI ──────────────────────────────────────────────────

install_tree_sitter_cli() {
  if has tree-sitter; then
    ok "tree-sitter CLI already installed."
    return
  fi

  if has cargo; then
    info "Installing tree-sitter-cli via cargo ..."
    cargo install tree-sitter-cli
  elif [[ $PM == brew ]]; then
    # already installed above via brew
    :
  elif has npm; then
    info "Installing tree-sitter-cli via npm ..."
    sudo npm install -g tree-sitter-cli
  else
    warn "Cannot install tree-sitter-cli — install Rust (rustup) or npm first."
    return
  fi

  ok "tree-sitter CLI installed."
}

# ── Nerd Font ─────────────────────────────────────────────────────────

install_nerd_font() {
  local font_dir
  if [[ "$OSTYPE" == darwin* ]]; then
    font_dir="$HOME/Library/Fonts"
  else
    font_dir="$HOME/.local/share/fonts"
  fi

  # Check if already installed
  if ls "$font_dir"/${NERD_FONT}* &>/dev/null 2>&1; then
    ok "$NERD_FONT Nerd Font already installed."
    return
  fi

  info "Installing $NERD_FONT Nerd Font v${NERD_FONT_VERSION} ..."
  local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONT_VERSION}/${NERD_FONT}.zip"
  local tmp
  tmp="$(mktemp -d)"

  curl -fsSL "$url" -o "$tmp/${NERD_FONT}.zip"
  mkdir -p "$font_dir"
  unzip -qo "$tmp/${NERD_FONT}.zip" -d "$font_dir" -x "LICENSE*" "README*"
  rm -rf "$tmp"

  # Rebuild font cache on Linux
  if has fc-cache; then
    fc-cache -f "$font_dir"
  fi

  ok "$NERD_FONT Nerd Font installed. Set it in your terminal emulator."
}

# ── main ──────────────────────────────────────────────────────────────

main() {
  info "Setting up prerequisites for nvim-config ..."
  echo

  detect_pm
  install_packages
  install_neovim
  install_tree_sitter_cli
  install_nerd_font

  echo
  ok "All done! Clone the config and run nvim:"
  echo "  git clone git@github.com:etapsc/nvim-config.git ~/.config/nvim"
  echo "  nvim"
}

main "$@"
