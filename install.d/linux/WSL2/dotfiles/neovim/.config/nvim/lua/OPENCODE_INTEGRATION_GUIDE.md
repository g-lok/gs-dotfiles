# OpenCode.nvim - LazyVim Integration Guide

## Overview

OpenCode.nvim is an AI-powered coding assistant that runs as an integrated terminal within Neovim. It provides contextual code assistance using `@this` (current file), `@buffer` (buffer content), and various prompt modes.

**Extra Location**: `lua/lazyvim/plugins/extras/ai/opencode.lua`

---

## Features

### Core Capabilities
- **Integrated Terminal**: Runs as a Neovim terminal buffer
- **Context Awareness**: Supports `@this` (current file), `@buffer` (buffer content), `@clipboard`, `@diff`
- **Visual Mode Support**: Send visual selections to OpenCode
- **Operator Pending Mode**: `go` and `goo` for adding ranges/lines
- **Built-in Prompts**: explain, fix, diagnose, review, test, optimize

### Key Behaviors
- Buffer hidden from bufferline/tabs (`buflisted = false`)
- Auto-enters insert mode when focusing OpenCode window
- Graceful process cleanup on VimLeave (kills child processes)

---

## Keymaps

### Custom LazyVim Keymaps (`<leader>a*`)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>aa` | n,t | Toggle OpenCode window |
| `<leader>aq` | n,t | Stop/Close OpenCode & terminate process |
| `<leader>as` | n,x | Select action (built-in prompt picker) |
| `<leader>ai` | n,x | Ask (empty prompt via Snacks input) |
| `<leader>aI` | n,x | Ask with context (`@this:` prefix) |
| `<leader>ab` | n,x | Ask about buffer (`@buffer:` prefix) |
| `<leader>aY` | n,x | Ask with clipboard (`@clipboard:` prefix) |
| `<leader>aP` | n,x | Ask with diff (`@diff:` prefix) |

### Prompt Shortcuts (`<leader>ap*`)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>ape` | n,x | Explain |
| `<leader>apf` | n,x | Fix |
| `<leader>apd` | n,x | Diagnose |
| `<leader>apr` | n,x | Review |
| `<leader>apt` | n,x | Test |
| `<leader>apo` | n,x | Optimize |

### Session Keymaps (`<leader>a*`)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>an` | n | New session |
| `<leader>ax` | n | Close current session |

### Operator Keymaps

| Keymap | Mode | Description |
|--------|------|-------------|
| `go` | n,x | Add range to OpenCode (use as operator, e.g., `goe` = add word) |
| `goo` | n | Add current line to OpenCode |

### Terminal-Only Keymaps (Local to OpenCode buffer)

| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-h>` | t,n | Navigate to left window |
| `<C-j>` | t,n | Navigate to lower window |
| `<C-k>` | t,n | Navigate to upper window |
| `<C-l>` | t,n | Navigate to right window |
| `<C-U>` | t | Half page up |
| `<C-D>` | t | Half page down |
| `<C-B>` | t | Full page up |
| `<C-F>` | t | Full page down |

---

## Workflow

### Starting OpenCode
1. **Toggle Mode**: `<leader>aa` - Opens/toggles the OpenCode terminal
2. **Ask Directly**: `<leader>ai` - Opens input prompt, type prompt, Enter to submit

### Context Modes
- **Empty Ask**: `<leader>ai` → Type freely → Enter to submit
- **With Current File**: `<leader>aI` → Adds `@this: ` prefix → Type prompt → Enter
- **With Buffer Content**: `<leader>ab` → Adds `@buffer: ` prefix → Type prompt → Enter
- **With Clipboard**: `<leader>aY` → Adds `@clipboard: ` prefix → Type prompt → Enter
- **With Diff**: `<leader>aP` → Adds `@diff: ` prefix → Type prompt → Enter
- **With Selection**: Select text in visual mode → `go` → Selection is sent to OpenCode buffer with `@this:` prefix → Type additional context if needed → Enter to submit

### Prompt Shortcuts
- `<leader>as` - Opens picker menu → select action → Enter (choose from: explain, fix, diagnose, review, test, optimize)
- `<leader>ape` - Directly triggers "explain" prompt
- `<leader>apf` - Directly triggers "fix" prompt
- `<leader>apd` - Directly triggers "diagnose" prompt
- `<leader>apr` - Directly triggers "review" prompt
- `<leader>apt` - Directly triggers "test" prompt
- `<leader>apo` - Directly triggers "optimize" prompt

### Stopping OpenCode
- `<leader>aq` - Terminates the process and closes the window

---

## Default Behavior (Not Overridden)

The following are the default opencode.nvim behaviors that work without customization:

### Default Keymaps (from plugin)
- `<C-s>` - Toggle visibility in terminal mode
- Built-in prompt picker via `select()`

> **Note**: LazyVim uses `gO` for LSP "go to definitions". This extra removes opencode.nvim's `gO` to preserve LSP behavior:
> ```lua
> vim.keymap.del("n", "gO")
> ```
> Users who want a separate terminal instance can open one directly.

### Default Options
- Default `opencode.toggle()` behavior
- Default `opencode.ask()` input handling
- Default `opencode.prompt()` functions
- Default `opencode.command()` for session control

### Visual Mode Defaults
- Default `v` operator integration (via `opencode.operator`)
- Default `@this` context for selections

---

## Proposed LazyVim Extras Changes

### 1. Add Which-Key Group
Add `<leader>a` as "OpenCode" group for discoverability:
```lua
which-key = {
  opts = {
    spec = {
      { "<leader>a", mode = { "n", "x" }, group = "OpenCode" },
      { "<leader>ap", mode = { "n", "x" }, group = "Prompt" },
      { "<leader>aP", mode = { "n", "x" }, group = "Patch" },
      { "<leader>aY", mode = { "n", "x" }, group = "Yank" },
    },
  },
}
```

### 2. Add Stop Keymap (`<leader>aq`)
Current plugin lacks a way to fully terminate the process. Add:
```lua
{
  "<leader>aq",
  function() require("opencode").stop() end,
  desc = "Stop/Close",
},
```

### 3. Add Terminal Navigation Keymaps
Add window navigation (`<C-h/j/k/l>`) and scrolling (`<C-U/D/B/F>`) local to the OpenCode buffer via TermOpen autocmd.

### 4. Fix Cursor Focus Issue
Default `opencode.ask()` jumps cursor to terminal. Recommend using `focus = false` option:
```lua
require("opencode").ask("", { submit = true, focus = false })
```

### 5. Process Cleanup on Exit
Add VimLeavePre autocmd to kill child processes:
```lua
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.fn.has("unix") == 1 then
      vim.fn.system({ "pkill", "-P", tostring(vim.fn.getpid()), "-f", "opencode" })
    end
  end,
})
```

---

## Notes

- The `<leader>a*` prefix is intentionally chosen to not conflict with LazyVim defaults
- All custom keymaps use `focus = false` to keep cursor in editor after asking
- Terminal keymaps are buffer-local (only active in OpenCode terminal)

---

## LazyVim Extra Scope

This extra is **config only**, not a plugin. Health checks belong in upstream `opencode.nvim` (`:checkhealth opencode`).

### Runtime Error Handling
Binary existence is a runtime check, not a health check. Use a safe wrapper in keymaps:
```lua
local function safe_ask(prompt, opts)
  if not vim.fn.executable("opencode") then
    vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
    return
  end
  require("opencode").ask(prompt, opts)
end
```

### Helper Functions
The extra includes two helper functions:
```lua
-- Wraps opencode.ask() with binary existence check
local function safe_ask(prompt, opts) end

-- Focuses the OpenCode window after toggle
local function focus_opencode() end
```

### Plugin Version
The extra pins the plugin with `version = "*"` to ensure updates are picked up automatically.