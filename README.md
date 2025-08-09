# 🏠 Dotfiles

Repository chứa các config files cho setup macOS của tôi.

## 📦 Bao gồm

### Shell & Terminal
- `.bashrc` - Bash configuration
- `.zshenv` - Zsh environment variables
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

## 🚀 Sử dụng

### Sync configs từ máy hiện tại vào dotfiles
```bash
cd ~/.dotfile
./sync.sh
```

### Apply configs từ dotfiles ra máy mới
```bash
# Clone repository
git clone <your-repo-url> ~/.dotfile
cd ~/.dotfile

# Copy configs
cp .bashrc ~/
cp .zshenv ~/
cp .condarc ~/
cp .gitconfig ~/
cp .tmux.conf ~/

# Copy directories
cp -r .hammerspoon ~/
cp -r .vim ~/
cp -r .tmux ~/

# Copy app configs
mkdir -p ~/.config
cp -r .config/* ~/.config/
```

### Cài đặt dependencies

#### Package managers
```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages từ Brewfile
brew bundle install
```

#### Window Management
```bash
# Yabai
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# SketchyBar  
brew tap FelixKratz/formulae
brew install sketchybar
```

#### Applications
```bash
# Karabiner-Elements
brew install --cask karabiner-elements

# Hammerspoon
brew install --cask hammerspoon

# Raycast
brew install --cask raycast
```

## 🔄 Workflow

1. **Cập nhật configs**: Chỉnh sửa configs trên máy như bình thường
2. **Sync changes**: Chạy `./sync.sh` để update dotfiles
3. **Push changes**: Git push để backup lên remote repository

## 📁 Cấu trúc

```
.dotfile/
├── .bashrc                 # Bash config
├── .zshenv                 # Zsh environment
├── .condarc                # Conda config  
├── .gitconfig              # Git config
├── .tmux.conf              # Tmux config
├── .hammerspoon/           # Hammerspoon scripts
├── .vim/                   # Vim config
├── .tmux/                  # Tmux plugins
├── .config/                # Application configs
│   ├── nvim/              # Neovim (LazyVim)
│   ├── yabai/             # Window manager
│   ├── skhd/              # Hotkey daemon
│   ├── sketchybar/        # Status bar
│   ├── karabiner/         # Key remapping
│   ├── raycast/           # Raycast launcher
│   └── htop/              # System monitor
├── sync.sh                 # Sync script
├── .gitignore             # Git ignore rules
└── README.md              # This file
```

## 🛠 Customization

Các config files đã được customize cho workflow của tôi, bao gồm:

- **Tiling window management** với Yabai
- **Custom status bar** với SketchyBar  
- **Vim keybindings** everywhere với Karabiner
- **Tmux setup** cho development
- **Neovim** với LazyVim distribution

## 📝 Notes

- Các configs được sync tự động với script `sync.sh`
- File `.gitignore` đã được setup để bỏ qua cache và log files
- SSH keys và sensitive data không được included

---

*Last updated: $(date '+%Y-%m-%d')* 