# 🏠 Dotfiles

Repository chứa các config files cho setup macOS của tôi, được quản lý bằng **GNU Stow**.

## 📦 Bao gồm

### Shell & Terminal
- `.bashrc` - Bash configuration
- `.zshenv` - Zsh environment variables
- `.zshrc` - Zsh configuration với Powerlevel10k
- `.p10k.zsh` - Powerlevel10k configuration
- `.tmux.conf` - Tmux configuration
- `.tmux/` - Tmux plugins và extensions

### Development Tools
- `.gitconfig` - Git configuration
- `.condarc` - Conda configuration
- `.vim/` - Vim configuration và plugins
- `.config/nvim/` - Neovim configuration (LazyVim)

### macOS Window Management
- `.config/yabai/` - Yabai window manager config
- `.config/skhd/` - Simple hotkey daemon config
- `.config/sketchybar/` - Status bar configuration
- `.hammerspoon/` - Hammerspoon Lua scripts

### Applications
- `.config/karabiner/` - Karabiner-Elements key remapping
- `.config/raycast/` - Raycast extensions và settings
- `.config/htop/` - Htop configuration
- `.config/alacritty/` - Alacritty terminal config
- `.config/btop/` - System monitor config

## 🚀 Setup với GNU Stow

### Cài đặt dependencies

```bash
# Cài đặt GNU Stow
brew install stow

# Cài đặt các packages khác từ Brewfile (nếu có)
brew bundle install
```

### Setup trên máy mới

```bash
# Clone repository
git clone <your-repo-url> ~/.dotfile
cd ~/.dotfile

# Setup dotfiles với Stow (tự động backup files cũ)
./install-stow.sh

# Reload shell
source ~/.zshrc
```

### Kiểm tra trạng thái

```bash
# Kiểm tra stow status
./check-stow.sh

# Hoặc dùng lệnh stow trực tiếp
stow -n dotfiles  # dry run - xem sẽ link gì
stow -v dotfiles  # verbose stow
```

## 🔄 Quản lý dotfiles hàng ngày

### Cập nhật configs
1. **Chỉnh sửa files**: Sửa files trong home directory như bình thường
2. **Commit changes**: Files đã được symlink nên tự động sync với repo
   ```bash
   cd ~/.dotfile
   git add -A
   git commit -m "Update configs"
   git push
   ```

### Thêm configs mới
```bash
cd ~/.dotfile
# Thêm file mới vào dotfiles package
cp ~/.newconfig dotfiles/
# Restow để tạo symlink
stow -R dotfiles
```

### Xóa configs
```bash
cd ~/.dotfile
# Xóa file từ package
rm dotfiles/.oldconfig
# Restow để xóa symlink
stow -R dotfiles
```

## 🛠 Lệnh Stow hữu ích

```bash
cd ~/.dotfile

# Link dotfiles
stow dotfiles

# Unlink dotfiles (remove symlinks)
stow -D dotfiles

# Relink dotfiles (useful after updates)
stow -R dotfiles

# Dry run - xem sẽ làm gì mà không thực hiện
stow -n dotfiles

# Verbose output
stow -v dotfiles
```

## 📁 Cấu trúc

```
.dotfile/
├── dotfiles/                  # Stow package
│   ├── .bashrc               # -> ~/.bashrc
│   ├── .zshrc                # -> ~/.zshrc
│   ├── .gitconfig            # -> ~/.gitconfig
│   ├── .tmux.conf            # -> ~/.tmux.conf
│   ├── .p10k.zsh             # -> ~/.p10k.zsh
│   ├── .hammerspoon/         # -> ~/.hammerspoon/
│   ├── .vim/                 # -> ~/.vim/
│   ├── .tmux/                # -> ~/.tmux/
│   └── .config/              # -> ~/.config/
│       ├── nvim/             # -> ~/.config/nvim/
│       ├── yabai/            # -> ~/.config/yabai/
│       ├── skhd/             # -> ~/.config/skhd/
│       ├── sketchybar/       # -> ~/.config/sketchybar/
│       ├── karabiner/        # -> ~/.config/karabiner/
│       └── ...
├── install-stow.sh           # Setup script
├── check-stow.sh            # Status check script
├── sync.sh                  # Legacy sync script
├── .gitignore               # Git ignore rules
└── README.md                # This file
```

## ✨ Ưu điểm của Stow

- **Symlinks**: Files luôn sync với repository
- **Safe**: Tự động backup files cũ
- **Flexible**: Dễ dàng add/remove configs
- **Standard**: GNU Stow là tool chuẩn cho dotfiles
- **No conflicts**: Chỉ link files có trong package

## 📝 Notes

- **Automatic sync**: Mọi thay đổi trong home directory tự động sync với repo
- **Backup**: Files cũ được backup trước khi stow
- **Gitignore**: Đã setup để ignore cache và sensitive files
- **SSH keys**: Không được included vì lý do bảo mật

## 🔧 Legacy Scripts

- `sync.sh` - Script cũ để copy files (deprecated)
- `install.sh` - Script cũ để setup symlinks thủ công (deprecated)
- `check-links.sh` - Script cũ để check manual symlinks (deprecated)

---

*Managed with ❤️ using GNU Stow* 