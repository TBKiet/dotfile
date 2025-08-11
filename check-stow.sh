#!/bin/bash

# Script để kiểm tra và quản lý stow status
# Hiển thị files nào đã được stow và cung cấp options để manage

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Kiểm tra nếu stow đã được cài đặt
if ! command -v stow &> /dev/null; then
    echo "❌ GNU Stow chưa được cài đặt!"
    echo "🍺 Cài đặt với: brew install stow"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}🔍 GNU Stow Status Check${NC}"
echo "📁 Dotfiles directory: $DOTFILES_DIR"
echo ""

# Kiểm tra nếu dotfiles package tồn tại
if [ ! -d "$DOTFILES_DIR/dotfiles" ]; then
    echo -e "${YELLOW}⚠️  Dotfiles package không tồn tại!${NC}"
    echo "💡 Chạy ./install-stow.sh để setup"
    exit 1
fi

echo -e "${BLUE}📦 Checking dotfiles package...${NC}"
echo "Package location: $DOTFILES_DIR/dotfiles/"

# Show what's in the dotfiles package
echo ""
echo -e "${CYAN}📋 Files in dotfiles package:${NC}"
find dotfiles -type f | head -20 | while read file; do
    echo "   📄 $file"
done

if [ $(find dotfiles -type f | wc -l) -gt 20 ]; then
    echo "   ... và $(( $(find dotfiles -type f | wc -l) - 20 )) files khác"
fi

echo ""
echo -e "${CYAN}📂 Directories in dotfiles package:${NC}"
find dotfiles -type d | grep -v "^dotfiles$" | head -10 | while read dir; do
    echo "   📁 $dir"
done

# Check stow status by looking at symlinks
echo ""
echo -e "${BLUE}🔗 Checking symlink status...${NC}"

stowed_count=0
broken_count=0
missing_count=0

# Function để check symlink status
check_stow_file() {
    local package_file="$1"
    local home_file="$HOME/${package_file#dotfiles/}"
    
    if [ -L "$home_file" ]; then
        # Check if symlink is valid (points to existing file/directory)
        if [ -e "$home_file" ]; then
            echo -e "${GREEN}✅ $(basename "$home_file"): Properly stowed${NC}"
            ((stowed_count++))
        else
            link_target=$(readlink "$home_file")
            echo -e "${RED}🔗 $(basename "$home_file"): Broken symlink${NC}"
            echo "   Link target: $link_target"
            ((broken_count++))
        fi
    elif [ -e "$home_file" ]; then
        echo -e "${YELLOW}📄 $(basename "$home_file"): File exists but not stowed${NC}"
        ((missing_count++))
    else
        echo -e "${YELLOW}⚠️  $(basename "$home_file"): Missing from home directory${NC}"
        ((missing_count++))
    fi
}

# Check some key files
echo ""
echo "Key dotfiles status:"
if [ -f "dotfiles/.zshrc" ]; then check_stow_file "dotfiles/.zshrc"; fi
if [ -f "dotfiles/.bashrc" ]; then check_stow_file "dotfiles/.bashrc"; fi
if [ -f "dotfiles/.gitconfig" ]; then check_stow_file "dotfiles/.gitconfig"; fi
if [ -f "dotfiles/.tmux.conf" ]; then check_stow_file "dotfiles/.tmux.conf"; fi

# Check if .config apps are stowed
echo ""
echo "Config applications:"
for config_dir in dotfiles/.config/*/; do
    if [ -d "$config_dir" ]; then
        check_stow_file "$config_dir"
    fi
done | head -5

echo ""
echo -e "${CYAN}📊 Summary:${NC}"
echo -e "${GREEN}✅ Properly stowed: $stowed_count${NC}"
echo -e "${YELLOW}⚠️  Not stowed/missing: $missing_count${NC}"
echo -e "${RED}❌ Broken links: $broken_count${NC}"

# Show available commands
echo ""
echo -e "${CYAN}🛠️  Available commands:${NC}"
echo "   ./install-stow.sh    - Setup/reorganize for stow"
echo "   stow -v dotfiles     - Stow dotfiles"
echo "   stow -D dotfiles     - Unstow dotfiles"
echo "   stow -R dotfiles     - Restow dotfiles (useful after updates)"
echo "   stow -n dotfiles     - Dry run (show what would be stowed)"

echo ""
if [ $missing_count -gt 0 ] || [ $broken_count -gt 0 ]; then
    echo -e "${YELLOW}💡 Suggestion: Chạy 'stow -R dotfiles' để restow${NC}"
else
    echo -e "${GREEN}🎉 All dotfiles are properly stowed!${NC}"
fi 