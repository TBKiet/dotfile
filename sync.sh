#!/bin/bash

# Script để sync config files từ máy hiện tại vào dotfiles
# Chạy script này để cập nhật dotfiles với config mới nhất

echo "🔄 Đang sync config files từ máy hiện tại vào dotfiles..."

# Basic dotfiles
echo "📁 Copy basic dotfiles..."
cp ~/.bashrc ./ 2>/dev/null || echo "Không tìm thấy .bashrc"
cp ~/.zshenv ./ 2>/dev/null || echo "Không tìm thấy .zshenv"
cp ~/.condarc ./ 2>/dev/null || echo "Không tìm thấy .condarc"
cp ~/.gitconfig ./ 2>/dev/null || echo "Không tìm thấy .gitconfig"
cp ~/.tmux.conf ./ 2>/dev/null || echo "Không tìm thấy .tmux.conf"

# Config directories
echo "📂 Copy config directories..."
cp -r ~/.hammerspoon ./ 2>/dev/null || echo "Không tìm thấy .hammerspoon"
cp -r ~/.vim ./ 2>/dev/null || echo "Không tìm thấy .vim"

# Tmux plugins (không copy git repos)
echo "🔧 Copy tmux configs..."
mkdir -p .tmux
cp -r ~/.tmux/plugins .tmux/ 2>/dev/null || echo "Không tìm thấy tmux plugins"

# Application configs (only config files, not cache/logs)
echo "⚙️  Copy application configs..."
mkdir -p .config

# Copy important app configs
for app in nvim sketchybar skhd yabai karabiner htop; do
    if [ -d ~/.config/$app ]; then
        echo "📝 Copy $app config..."
        cp -r ~/.config/$app .config/
    fi
done

# Git operations
echo "📊 Checking git status..."
git add -A

if git diff --staged --quiet; then
    echo "✅ Không có thay đổi nào để commit"
else
    echo "💾 Commit changes..."
    git commit -m "Auto sync: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "✅ Đã cập nhật dotfiles thành công!"
fi

echo "🎉 Hoàn thành sync!" 