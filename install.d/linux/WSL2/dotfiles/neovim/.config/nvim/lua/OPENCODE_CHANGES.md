# OpenCode Neovim Plugin - Changes Summary

## Issues Fixed

### 1. Blink.cmp Mapping Freeze
**Problem:** Using `<C-e>` to toggle autosuggestions worked to close, but reopening caused editor freeze (infinite loop).

**Fix in `lua/config/keymaps.lua`:**
- Changed from `vim.api.nvim_feedkeys()` to `blink.show()` to explicitly show the completion menu

### 2. Couldn't Close Snack Input Popup
**Problem:** When using `<leader>ai` (Ask), the popup showed but there was no obvious way to close it. ESC wasn't working.

**Fix in `lua/plugins/opencode.lua`:**
- Added keymap to snacks input styles to close with `<Esc>`:
```lua
{
  "folke/snacks.nvim",
  optional = true,
  opts = {
    styles = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
},
```

### 3. Cursor Focus Issue
**Problem:** When using `<leader>ai`, the cursor jumped to the opencode terminal instead of staying in the editor.

**Fix:** Added `focus = false` to all `ask()` keymaps:
- `<leader>ai` - Ask (empty prompt)
- `<leader>aI` - Ask with context
- `<leader>ab` - Ask about buffer

### 4. Duplicate Key Mapping Warning
**Problem:** Snacks input had duplicate `<Esc>` keymap causing warning.

**Fix in `lua/plugins/opencode.lua`:**
- Removed `<Esc>` mapping (already handled by LazyVim/LuaSnip)
- Kept only `<C-c>` for closing snacks input

### 5. Auto-Focus Still Jumping Cursor
**Problem:** Even with `focus = false`, the cursor still jumped to opencode terminal after `<leader>ai` because of a `defer_focus(5000)` call in the TermOpen autocmd.

**Fix in `lua/plugins/opencode.lua`:**
- Removed the `defer_focus(5000)` call entirely
- Removed the unused `defer_focus` function

### 6. <C-c> Interfering with Terminal SIGINT
**Problem:** Using `<C-c>` to close snacks input interfered with zsh's SIGINT shortcut.

**Fix in `lua/plugins/opencode.lua`:**
- Removed `<C-c>` keymap, keeping only `<Esc>` for closing

### 7. No Way to Fully Close/Stop OpenCode
**Problem:** `<leader>aa` only toggles (show/hide), keeping the process running. No way to actually terminate the process and kill the window.

**Fix in `lua/plugins/opencode.lua`:**
- Added `<leader>aq` keymap to call `require("opencode").stop()` and terminate the process

## Keymaps Added

### In Snacks Input
- `<Esc>` - Close the input popup

### In OpenCode Prompt
- `<S-CR>` (Shift+Enter) - Append instead of submit
- `<CR>` (Enter) - Submit the prompt

### New Keymaps
- `<leader>aa` - Toggle (show/hide) opencode window
- `<leader>aq` - **Stop/Close opencode and terminate the process**

## To Test

- [ ] Blink.cmp `<C-e>` toggle works without freeze
- [ ] Snacks input popup closes with `<Esc>`
- [ ] Cursor stays in editor after `<leader>ai`, `<leader>aI`, `<leader>ab`
- [ ] `<leader>aq` stops the opencode process and closes the window

## Note
The `<S-CR>` keymap means **Shift + Enter**, not right control. It's a standard key for "append" in the opencode input dialog.