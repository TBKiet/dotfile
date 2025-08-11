#!/bin/bash

# Script để setup dotfiles sử dụng GNU Stow
# Stow tự động tạo symlinks từ dotfiles directory vào home directory

set -e

# Kiểm tra nếu stow đã được cài đặt
if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow chưa được cài đặt!"
    echo "🍺 Cài đặt với Homebrew:"
    echo "   brew install stow"
    echo ""
    echo "📖 Hoặc cài với package manager khác:"
    echo "   macOS: brew install stow"
    echo "   Ubuntu/Debian: sudo apt install stow"
    echo "   Arch: sudo pacman -S stow"
    exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "🔗 Đang setup dotfiles với GNU Stow..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Tạo cấu trúc thư mục cho stow
echo ""
echo "🏗️  Chuẩn bị cấu trúc thư mục cho Stow..."

# Tạo package directories nếu chưa có
mkdir -p dotfiles/{.config,.hammerspoon,.vim,.tmux}

# Di chuyển các dotfiles vào package directory
echo "📦 Tổ chức dotfiles vào package structure..."

# Basic dotfiles
for file in .bashrc .bash_profile .zshenv .zshrc .zprofile .condarc .gitconfig .gitignore_global .tmux.conf .p10k.zsh; do
    if [ -f "$file" ]; then
        if [ ! -f "dotfiles/$file" ]; then
            echo "📝 Moving $file to dotfiles package..."
            mv "$file" "dotfiles/"
        fi
    fi
done

# Directories
for dir in .hammerspoon .vim .tmux; do
    if [ -d "$dir" ] && [ ! -L "dotfiles/$dir" ]; then
        echo "📂 Moving $dir to dotfiles package..."
        mv "$dir" "dotfiles/"
    fi
done

# Config directory - di chuyển từng app config
if [ -d ".config" ]; then
    echo "⚙️  Moving .config applications..."
    if [ ! -d "dotfiles/.config" ]; then
        mkdir -p "dotfiles/.config"
    fi
    
    for app_dir in .config/*; do
        if [ -d "$app_dir" ]; then
            app_name=$(basename "$app_dir")
            if [ ! -d "dotfiles/.config/$app_name" ]; then
                echo "📱 Moving .config/$app_name..."
                mv "$app_dir" "dotfiles/.config/"
            fi
        fi
    done
    
    # Remove empty .config if exists
    if [ -d ".config" ] && [ -z "$(ls -A .config)" ]; then
        rmdir .config
    fi
fi

# Backup existing files trong home directory
echo ""
echo "💾 Backup existing files..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup file if it exists and is not a symlink
backup_if_exists() {
    local file="$1"
    if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        echo "📦 Backup ~/$file"
        cp -r "$HOME/$file" "$BACKUP_DIR/"
        rm -rf "$HOME/$file"
    fi
}

# Backup dotfiles nếu chúng tồn tại và không phải symlink
backup_if_exists ".bashrc"
backup_if_exists ".bash_profile"
backup_if_exists ".zshenv"
backup_if_exists ".zshrc"
backup_if_exists ".zprofile"
backup_if_exists ".condarc"
backup_if_exists ".gitconfig"
backup_if_exists ".gitignore_global"
backup_if_exists ".tmux.conf"
backup_if_exists ".p10k.zsh"
backup_if_exists ".hammerspoon"
backup_if_exists ".vim"
backup_if_exists ".tmux"

# Backup .config apps
if [ -d "$HOME/.config" ]; then
    for app_dir in dotfiles/.config/*; do
        if [ -d "$app_dir" ]; then
            app_name=$(basename "$app_dir")
            backup_if_exists ".config/$app_name"
        fi
    done
fi

# Stow dotfiles
echo ""
echo "🔗 Stowing dotfiles..."
cd "$DOTFILES_DIR"

# Stow the dotfiles package
stow -v dotfiles

echo ""
echo "✅ Hoàn thành setup với GNU Stow!"
echo ""
echo "📝 Notes:"
echo "   - Dotfiles đã được stow từ: $DOTFILES_DIR/dotfiles/"
echo "   - Files cũ được backup tại: $BACKUP_DIR"
echo "   - Để unstow: cd $DOTFILES_DIR && stow -D dotfiles"
echo "   - Để restow: cd $DOTFILES_DIR && stow -R dotfiles"
echo ""
echo "🔄 Để reload shell config:"
echo "   source ~/.zshrc" 