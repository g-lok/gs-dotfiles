# Reference & TODOs

Detailed reference for current setup, keymaps, and pending work. Read SESSION.md first for overview.

---

## Table of Contents

- [Active Projects / Workspaces](#active-projects--workspaces)
- [Current Setup](#current-setup)
- [Keymaps](#keymaps)
  - [Kitty (ctrl+alt)](#kitty-ctrlalt)
  - [Zellij (ctrl+shift)](#zellij-ctrlshift)
  - [GNOME/Shell (Super/Alt)](#gnomshell-superalt)
  - [LazyVim (Neovim)](#lazyvim-neovim)
- [Layer Comparison](#layer-comparison)
- [Key Configurations](#key-configurations)
- [Testing Checklist](#testing-checklist)
- [TODOs](#todos)
- [Notes](#notes)
- [Backup/Install Location](#backupinstall-location)
- [Jujutsu (jj) Reference](./JJ_QUICKREF.md)

---

## Active Projects / Workspaces

| Project | Path | Status | Last Updated |
|---------|------|--------|--------------|
| gs-dotfiles generalization | ~/gitclones/gs-dotfiles/ | In progress | 2026-03-28 |
| Kitty/Zellij/LazyVim setup | ~/.config/kitty/, ~/.config/zellij/ | Stable | 2026-03-28 |

**Current working directory**: `/home/g` (global)

*When working in a project, update this section and add entry to chat_history.md*

---

## Current Setup

### Environment
- **Terminal**: Kitty 0.46.2 (Linux), Ghostty (macOS)
- **Editor**: Neovim 0.11.6 with LazyVim v15
- **Multiplexer**: Zellij (default_mode: "locked")
- **Shell**: Zsh with Oh My Zsh
- **Desktop**: GNOME (Kali Linux), macOS
- **Package Manager**: Homebrew/linuxbrew

### kitty_mod Configuration
Changed from `ctrl+shift` → `ctrl+alt` to allow ctrl+shift to pass through to Zellij.

---

## Keymaps

### Kitty (ctrl+alt)
| Keymap | Action |
|--------|--------|
| ctrl+alt+enter | new_window |
| ctrl+alt+n | new_os_window |
| ctrl+alt+c | copy_to_clipboard |
| ctrl+alt+v | paste_from_clipboard |
| ctrl+alt+w | close_window |
| ctrl+alt+r | start_resizing_window |
| ctrl+alt+home/end | scroll_home/scroll_end |
| ctrl+alt+page_up/down | previous_window/next_window |
| ctrl+alt++/+= | increase font size |
| ctrl+alt+- | decrease font size |

### Kitty (super - macOS-like)
| Keymap | Action |
|--------|--------|
| super+c | copy_to_clipboard |
| super+v | paste_from_clipboard |

### Zellij (ctrl+shift - passed through from Kitty)
| Keymap | Action |
|--------|--------|
| ctrl+shift+h/j/k/l | MoveFocus (pane nav) |
| ctrl+shift+arrows | MoveFocus/Tab |
| ctrl+shift++/- | Resize panes |
| ctrl+shift+[/] | Swap layouts |
| ctrl+shift+1-9 | Goto tab |
| ctrl+shift+n | New pane |
| ctrl+shift+f | Toggle floating |
| ctrl+shift+i/o | Move tab |
| ctrl+g | Switch to locked mode |
| enter/esc | Switch to locked mode |

### Kitty Built-in Disabled (no_op)
| Keymap | Reason |
|--------|--------|
| ctrl+shift++/- | Conflicting with Zellij resize |

### GNOME/Shell (Super/Alt)

**Window Management (Super)**
| Keymap | Action |
|--------|--------|
| Super+Up | Maximize |
| Super+Down | Unmaximize |
| Super+Left | Toggle Tiled Left |
| Super+Right | Toggle Tiled Right |
| Super+h | Minimize |
| Super+d | Show Desktop |
| Super+Tab | Switch Applications |
| Super+Shift+Tab | Switch Applications (backward) |
| Super+` | Switch Group |
| Super+1-9 | Switch to Application 1-9 |
| Super+Shift+1-9 | Open New Window for App 1-9 |
| Super+p | Switch Monitor |
| Super+Escape | Restore Shortcuts |

**Workspaces (Super)**
| Keymap | Action |
|--------|--------|
| Super+Home | Switch to Workspace 1 |
| Super+End | Switch to Last Workspace |
| Super+Page_Up | Switch to Workspace Left |
| Super+Page_Down | Switch to Workspace Right |
| Super+Shift+Home | Move to Workspace 1 |
| Super+Shift+End | Move to Last Workspace |
| Super+Shift+Page_Up | Move to Workspace Left |
| Super+Shift+Page_Down | Move to Workspace Right |
| Super+Shift+Up/Down/Left/Right | Move to Monitor |

**Alt Keybindings**
| Keymap | Action |
|--------|--------|
| Alt+F4 | Close |
| Alt+F7 | Begin Move |
| Alt+F8 | Begin Resize |
| Alt+F10 | Toggle Maximized |
| Alt+F5 | Unmaximize |
| Alt+Space | Activate Window Menu |
| Alt+Tab | Switch Windows |
| Alt+Shift+Tab | Switch Windows (backward) |
| Alt+F6 | Cycle Group |
| Alt+Escape | Cycle Windows |
| Alt+Shift+Escape | Cycle Windows (backward) |
| Alt+F2 | Run Dialog |

**Screen/Brightness (XF86 keys)**
| Keymap | Action |
|--------|--------|
| XF86MonBrightnessUp | Brightness Up |
| XF86MonBrightnessDown | Brightness Down |
| XF86ScreenBrightnessCycle | Brightness Cycle |

**Screenshots (Shell)**
| Keymap | Action |
|--------|--------|
| Print | Screenshot UI |
| Shift+Print | Screenshot |
| Alt+Print | Screenshot Window |

**Overview/Quick Settings**
| Keymap | Action |
|--------|--------|
| Super+a | Toggle Application View |
| Super+m | Toggle Message Tray |
| Super+v | Toggle Message Tray |
| Super+s | Toggle Quick Settings |
| Super+n | Focus Active Notification |
| Super+Alt+Up | Shift Overview Up |
| Super+Alt+Down | Shift Overview Down |

**Sessions (Alt+Ctrl+F1-F12)**
| Keymap | Action |
|--------|--------|
| Alt+Ctrl+F1 | Switch to Session 1 |
| Alt+Ctrl+F2 | Switch to Session 2 |
| ... | ... |
| Alt+Ctrl+F12 | Switch to Session 12 |

---

## Layer Comparison

| Layer | Modifier | Conflicts? |
|-------|----------|------------|
| Kitty | ctrl+alt | No |
| Kitty | super | No |
| Zellij | ctrl+shift | No |
| LazyVim | ctrl/alt | No (handled inside Neovim) |
| GNOME | alt/super | No |

---

## Key Configurations

### Kitty Stderr Wrapper
- Location: ~/.local/bin/kitty
- Purpose: Suppress [PARSE ERROR] messages from systemd journal

### Zellij Auto-Start
- Currently **disabled** in ~/.zshrc (commented out)
- Can enable by uncommenting the block after .shellrc/ load

### Zsh Escape Code Fix
- In ~/.zshrc - kitty_nvim_cleanup function
- Strips leaked CSI t 8 codes after Ctrl+z/fg

### Keyboard Repeat (GNOME Wayland - FIXED)
**CLI Commands:**
```bash
# Hardware keyboard repeat (system-wide)
gsettings set org.gnome.desktop.peripherals.keyboard repeat true
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 10  # ms between repeats (lower=faster)
gsettings set org.gnome.desktop.peripherals.keyboard delay 200           # ms before repeat starts

# GTK apps key repeat (separate from hardware)
gsettings set org.gnome.desktop.interface gtk-timeout-repeat 20   # ms between repeats
gsettings set org.gnome.desktop.interface gtk-timeout-initial 200 # ms before repeat starts

# Verify current settings
gsettings get org.gnome.desktop.peripherals.keyboard repeat-interval
gsettings get org.gnome.desktop.peripherals.keyboard delay
gsettings get org.gnome.desktop.interface gtk-timeout-repeat
```

**GUI**: Settings → Accessibility → Typing → Repeat Keys (sliders work immediately!)

**Backup**: `~/gitclones/gs-dotfiles/install.d/linux/kali/settings.dconf`

---

## Files Modified

- ~/.config/kitty/kitty.conf - main config
- ~/.config/kitty/SESSION.md - moved to ~/.session/
- ~/.config/kitty/TODO.md - renamed to REFERENCE.md
- ~/.local/bin/kitty - wrapper script
- ~/.local/share/applications/kitty.desktop - launcher
- ~/.zshrc - escape code cleanup + zellij (disabled)
- ~/.session/ - new central location for context files

## Backup Structure (gs-dotfiles)

**Kali backup location**: `~/gitclones/gs-dotfiles/install.d/linux/kali/`

| Path | Description |
|------|-------------|
| `dotfiles/kitty-linux/.config/kitty/` | Kitty config (stowed from ~/dotfiles) |
| `dotfiles/kitty-linux/.local/bin/kitty` | Kitty wrapper script |
| `dotfiles/kitty-linux/.local/share/applications/kitty.desktop` | Desktop launcher |
| `session/` | AI session context files |
| `settings.dconf` | GNOME settings |
| `apt-packages.list` | APT packages |
| `ohmyzsh.tar.gz` | Oh My Zsh config |

**Stow setup**: Use `~/dotfiles/dotfiles.sh` to symlink configs from `~/gitclones/gs-dotfiles/install.d/linux/kali/dotfiles/`

---

## Testing Checklist

### Escape Code Leak Fix
- [x] zsh hook filters leaked CSI t 8 codes
- [x] No zsh hook errors on startup
- [ ] Test Ctrl+z / fg in Neovim

### Key Bindings
- [x] Zellij pane navigation (ctrl+shift+hjkl)
- [x] Zellij resize (ctrl+shift++/-)
- [x] Zellij swap layouts (ctrl+shift+[/])
- [x] Zellij tabs (ctrl+shift+1-9)
- [x] Kitty new window (ctrl+alt+enter)
- [x] Kitty copy/paste (super+c/v)
- [x] Kitty font size (ctrl+alt+/-)
- [ ] Test super+c/v in other apps (expected: doesn't work, use ctrl+c/v)

### Zellij
- [ ] Auto-start on new window (currently disabled)
- [ ] Locked mode by default
- [ ] ctrl+g unlocks

---

## TODOs

### 1. Refactor gs-dotfiles for Generalization
**Goal**: Move personalized variants to private ~/dotfiles, make gs-dotfiles generic for wider audience.

- [ ] Audit gs-dotfiles for user-specific paths/configs
- [ ] Create platform-agnostic base configs in gs-dotfiles
- [ ] Move personal variants to ~/dotfiles
- [ ] Update install scripts to support both generic and personalized installs
- [ ] Document how users can override base configs with personal variants

**Personal configs to move out** (currently in gs-dotfiles):
- ~/dotfiles/zellij-macos-intel/ → personal variant
- ~/dotfiles/zellij-linux/ → personal variant
- Other platform-specific personalizations

### 2. Keyboard Repeat on GNOME Wayland
- [x] Set gsettings (10ms interval, 200ms delay)
- [x] Found correct location: Settings → Accessibility → Typing → Repeat Keys
- [x] Works immediately - no logout needed!
- [x] Updated backup in gs-dotfiles

### 3. Sync to Main Install System
The Kali-specific backup/install scripts are in: ~/gitclones/gs-dotfiles/install.d/linux/kali/

- [ ] Update main install.d with Kali install.sh improvements
- [ ] Merge Kali-specific packages into platform-specific Brewfiles
- [ ] Add kitty to main dotfiles if not present
- [ ] Ensure zellij-linux is the default on Linux
- [ ] Test install/backup on clean Kali VM

---

## LazyVim Keymaps

### Leader Key: `<space>`

**`<leader>a` - OpenCode**
| Keymap | Action |
|--------|--------|
| aa | Toggle OpenCode |
| ai | Ask (empty) |
| aI | Ask with context |
| ab | Ask about buffer |
| av | Ask with visible text |
| as | Select action |
| an | New session |
| ac | Close session |
| aq | Stop/Close OpenCode |
| aB | Ask with all buffers |
| am | Ask with marks |
| ax | Ask with quickfix |

**`<leader>b` - Buffers**
| Keymap | Action |
|--------|--------|
| bd | Delete Buffer |
| bD | Delete Buffer and Window |
| bo | Delete Other Buffers |
| bp | Toggle Pin |
| bj | Pick Buffer |
| br | Delete Buffers to the Right |
| bl | Delete Buffers to the Left |
| bP | Delete Non-Pinned Buffers |
| bb | Switch to Other Buffer |

**`<leader>c` - Code/LSP**
| Keymap | Action |
|--------|--------|
| ca | Code Action |
| cf | Format |
| cr | Rename (inc-rename) |
| cl | Lsp Info |
| cm | Mason |
| cc | Run Codelens |
| cC | Refresh & Display Codelens |
| cd | Line Diagnostics |
| cs | Symbols (Trouble) |
| cS | LSP references/definitions (Trouble) |
| cR | Rename File |
| cF | Format Injected Langs |

**`<leader>d` - DAP/Debug**
| Keymap | Action |
|--------|--------|
| dc | Run/Continue |
| db | Toggle Breakpoint |
| dB | Breakpoint Condition |
| da | Run with Args |
| dl | Run Last |
| dg | Go to Line (No Execute) |
| dt | Terminate |
| di | Step Into |
| do | Step Out |
| dO | Step Over |
| dC | Run to Cursor |
| du | Dap UI |
| dw | Widgets |
| ds | Session |
| dr | Toggle REPL |
| dpp | Toggle Profiler |

**`<leader>e` - Explorer**
| Keymap | Action |
|--------|--------|
| e | Open mini.files (directory of current file) |
| E | Open mini.files (cwd) |

**`<leader>f` - Find/Files**
| Keymap | Action |
|--------|--------|
| ff | Find Files (Root Dir) |
| fF | Find Files (cwd) |
| fg | Find Files (git-files) |
| fe | Explorer Snacks (root dir) |
| fE | Explorer Snacks (cwd) |
| fp | Projects |
| fr | Recent |
| fR | Recent (cwd) |
| ft | Terminal (Root Dir) |
| fT | Terminal (cwd) |
| fb | Buffers |
| fB | Buffers (all) |
| fc | Find Config File |
| fn | New File |

**`<leader>g` - Git**
| Keymap | Action |
|--------|--------|
| gs | Git Status |
| gl | Git Log |
| gd | Git Diff (hunks) |
| gG | Lazygit (cwd) |
| gg | Lazygit (Root Dir) |
| gb | Git Blame Line |
| gh | Git Hunks |
| gS | Git Stash |
| gL | Git Log (cwd) |
| gY | Git Browse (copy) |
| gB | Git Browse (open) |
| gi | GitHub Issues (open) |
| gI | GitHub Issues (all) |
| gp | GitHub Pull Requests (open) |
| gP | GitHub Pull Requests (all) |
| gf | Git Current File History |
| gD | Git Diff (origin) |
| ghp | Preview Hunk Inline |
| ghr | Reset Hunk |
| ghs | Stage Hunk |
| ghu | Undo Stage Hunk |
| ghb | Blame Line |
| ghd | Diff This |
| ghD | Diff This ~ |
| ghS | Stage Buffer |
| ghR | Reset Buffer |
| ghB | Blame Buffer |

**`<leader>p` - Yank/YankRing**
| Keymap | Action |
|--------|--------|
| p | Open Yank History |

**`<leader>q` - Sessions**
| Keymap | Action |
|--------|--------|
| qs | Restore Session |
| ql | Restore Last Session |
| qd | Don't Save Current Session |
| qS | Select Session |
| qq | Quit All |

**`<leader>r` - Refactor**
| Keymap | Action |
|--------|--------|
| r | +refactor |
| rf | Extract Function |
| ri | Inline Variable |
| rb | Extract Block |
| rs | Refactor |
| rx | Extract Variable |
| rF | Extract Function To File |
| rp | Debug Print Variable |
| rP | Debug Print |
| rc | Debug Cleanup |

**`<leader>s` - Search (Snacks Picker)**
| Keymap | Action |
|--------|--------|
| sk | Keymaps |
| sg | Grep (Root Dir) |
| sG | Grep (cwd) |
| sd | Diagnostics |
| sD | Buffer Diagnostics |
| ss | LSP Symbols |
| sS | LSP Workspace Symbols |
| sb | Buffer Lines |
| sB | Grep Open Buffers |
| sc | Command History |
| sC | Commands |
| sh | Help Pages |
| sH | Highlights |
| sp | Search for Plugin Spec |
| sr | Search and Replace |
| st | Todo |
| su | Undotree |
| sT | Todo/Fix/Fixme |
| sm | Marks |
| sj | Jumps |
| si | Icons |
| sa | Autocmds |
| sq | Quickfix List |
| sl | Location List |
| sr | Resume |
| s" | Registers |
| s/ | Search History |
| sw | Visual selection or word (Root Dir) |
| sW | Visual selection or word (cwd) |

**`<leader>t` - Test (Neotest)**
| Keymap | Action |
|--------|--------|
| tt | Run File (Neotest) |
| tr | Run Nearest (Neotest) |
| tl | Run Last (Neotest) |
| ta | Attach to Test (Neotest) |
| ts | Toggle Summary (Neotest) |
| tw | Toggle Watch (Neotest) |
| td | Debug Nearest |
| to | Show Output (Neotest) |
| tS | Stop (Neotest) |
| tT | Run All Test Files (Neotest) |
| tO | Toggle Output Panel (Neotest) |

**`<leader>u` - UI Toggles**
| Keymap | Action |
|--------|--------|
| ua | Toggle Animations |
| ub | Toggle Dark Background |
| uc | Toggle Conceal Level |
| ud | Toggle Diagnostics |
| uf | Toggle Auto Format (Global) |
| ug | Toggle Indent Guides |
| uh | Toggle Inlay Hints |
| ui | Inspect Pos |
| ul | Toggle Line Numbers |
| un | Dismiss All Notifications |
| up | Toggle Mini Pairs |
| us | Toggle Spelling |
| uw | Toggle Wrap |
| uz | Toggle Zen Mode |
| uA | Toggle Tabline |
| uC | Colorschemes |
| uD | Toggle Dimming |
| uF | Toggle Auto Format (Buffer) |
| uG | Toggle Git Signs |
| uI | Inspect Tree |
| uL | Toggle Relative Number |
| uS | Toggle Smooth Scroll |
| uT | Toggle Treesitter Highlight |
| uZ | Toggle Zoom Mode |

**`<leader>w` - Windows**
| Keymap | Action |
|--------|--------|
| wd | Delete Window |
| wm | Toggle Zoom Mode |

**`<leader>x` - Trouble**
| Keymap | Action |
|--------|--------|
| xx | Diagnostics (Trouble) |
| xq | Quickfix List (Trouble) |
| xl | Location List (Trouble) |
| xt | Todo (Trouble) |
| xX | Buffer Diagnostics (Trouble) |
| xT | Todo/Fix/Fixme (Trouble) |

**`<leader>,` - Buffers**
| Keymap | Action |
|--------|--------|
| , | Buffers |

**`<leader>/` - Grep**
| Keymap | Action |
|--------|--------|
| / | Grep (Root Dir) |

**`<leader>-` - Windows**
| Keymap | Action |
|--------|--------|
| - | Split Window Below |

**`<leader>|` - Windows**
| Keymap | Action |
|--------|--------|
| | | Split Window Right |

**`<leader>l` - Lazy**
| Keymap | Action |
|--------|--------|
| l | Lazy |

**`<leader>n` - Notifications**
| Keymap | Action |
|--------|--------|
| n | Notification History |

**`;` - Mini Surround**
| Keymap | Action |
|--------|--------|
| ;; | Add Surrounding |
| ;d | Delete Surrounding |
| ;r | Replace Surrounding |
| ;f | Find Right Surrounding |
| ;F | Find Left Surrounding |
| ;h | Highlight Surrounding |
| ;n | Update `MiniSurround.config.n_lines` |

**`<C-w>` - Window Hydra Mode**
| Keymap | Action |
|--------|--------|
| <C-w> | Window Hydra Mode |

**Insert Mode**
| Keymap | Action |
|--------|--------|
| <C-s> | Save File |
| <M-j> | Move Down |
| <M-k> | Move Up |

**Visual Mode**
| Keymap | Action |
|--------|--------|
| <C-s> | Save File |

---

## Notes

- Linux apps don't support Super+c/v like macOS - use ctrl+c/v in non-Kitty apps
- The wrapper script at ~/.local/bin/kitty suppresses [PARSE ERROR] in journalctl
- Escape code leak handled by zsh hook in .zshrc

---

## Backup/Install Location

**Kali**: ~/gitclones/gs-dotfiles/install.d/linux/kali/
- install.sh - full environment installer
- backup.sh - update backup files before reinstalling
- dotfiles/ - stow dotfiles
- settings.dconf - GNOME settings
- apt-packages.list - APT packages
- ohmyzsh.tar.gz - Oh My Zsh config
