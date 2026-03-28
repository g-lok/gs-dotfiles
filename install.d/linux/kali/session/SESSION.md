# AI Session Context

**This file is for the AI's benefit** - read this first on every fresh session to understand the user's setup, workflow, and where to find reference information.

## Quick Start

1. **Read this file** for setup overview
2. **Read `REFERENCE.md`** for current config, keymaps, todos, and detailed context
3. **Check `.session/chat_history.md`** for conversation context if resuming work

## What This Is

- **SESSION.md**: High-level overview for AI onboarding (you're reading it)
- **REFERENCE.md**: Detailed current state, keymaps, TODOs, changes, and reference info
- **chat_history.md**: Log of conversation to resume long-running tasks

## User Setup Summary

- **Terminal**: Kitty (Linux), Ghostty (macOS)
- **Editor**: Neovim (LazyVim v15, Neovim 0.11.6)
- **Multiplexer**: Zellij
- **Shell**: Zsh with Oh My Zsh
- **Desktop**: GNOME (Kali Linux), macOS (personal MacBook)
- **Package Manager**: Homebrew (linuxbrew on Linux)

## Key Preferences

- **kitty_mod**: `ctrl+alt` (not ctrl+shift - allows ctrl+shift to pass through to Zellij)
- **Keyboard repeat**: Fast (10ms interval, 200ms delay - GNOME Wayland, requires logout/login to apply)
- **Zellij**: Auto-start disabled for now (can enable in .zshrc)
- **Stderr wrapper**: ~/.local/bin/kitty suppresses [PARSE ERROR] in systemd journal

## Important Files

- **Config**: ~/.config/kitty/kitty.conf
- **Shell**: ~/.zshrc
- **Reference**: ~/.session/REFERENCE.md
- **Backup/Install**: ~/gitclones/gs-dotfiles/install.d/linux/kali/

## Current Project

Refactoring gs-dotfiles to be more generalized for wider audience, moving personal variants to private ~/dotfiles. See REFERENCE.md for details.

## How to Use These Files

**When starting a new session:**
1. Read SESSION.md (this file)
2. Read REFERENCE.md for full context
3. Check if there's a chat_history.md to resume work

**When work is completed or context changes:**
1. Update REFERENCE.md with new keymaps, settings, or notes
2. Add completed/new TODOs to REFERENCE.md
3. Keep both files current - they're your memory

## Updating Context

### REFERENCE.md
Update with current configuration, keymaps, TODOs, and reference info - should be a clean snapshot of current state.

### SESSION.md / chat_history.md
Log work history including:
- What you worked on and why
- **Notable failures** and what didn't work
- **Pivots** - when you changed approach or direction
- **New information learned** through trial/error, docs, web searches, or code
- Anything that would help a future session avoid repeating mistakes

Think of this as your "learning log" - capture the journey, not just the destination.

---

## Project/Workspace Sessions

### For Project-Scoped Sessions (e.g., in a git repo)
Each project should have its own session context. When working in a project:

1. **First, read the global context files** (`~/.session/SESSION.md`, `~/.session/REFERENCE.md`)
2. **Project SESSION.md should reference the globals** at the top:
   ```markdown
   **ALWAYS READ FIRST**: ~/.session/SESSION.md
   ```
3. **Update globals** with a reference to the project session:
   - Add entry to `~/.session/REFERENCE.md` → "Active Projects" section
   - Or append to `~/.session/chat_history.md` with project path

### For Local Workspaces
If working in a subdirectory or workspace (not the global `/home/g`):

1. **Update global logs** to track where you're working:
   - Add/update entry in `~/.session/REFERENCE.md` "Active Projects" section
   - Include: project path, what you're working on, pending items
   
2. **Create local session file** if needed (e.g., `.session/SESSION.md` in project root)
   - Reference the global files
   - Document project-specific context

### Summary
- **Globals** (`~/.session/*`) know about all projects
- **Projects** know about the globals
- **Bidirectional** - always reference each other

---

## Jujutsu (jj) Version Control - IMPORTANT

**⚠️ CRITICAL: This user uses Jujutsu (jj) for version control.**

### When in a jj repository (.jj folder exists):
- **ONLY use jj commands** - never use raw git commands
- NEVER run `jj git *` commands - only the USER operates jj directly
- Use jj for all VCS operations (commit, rebase, log, status, etc.)
- If you need to push/pull, tell the USER to run `jj git push`/`jj git fetch`

### When in a Git repository (no .jj folder):
- Ask the user first before using git commands
- Or recommend they set up jj for that repo

### When User Asks to Create Commits on a "Branch"

If user asks you to create commits on a specific "branch" or from a specific parent:
1. Only make commits on YOUR revision tree
2. Do NOT touch/modify the user's commits or their tree
3. Keep your changes completely separate from user's work

Example:
- User has commits A → B → C (user's tree)
- User asks you to work from C
- You create: C → D → E (your tree, separate from user)
- You never modify A, B, or C

### jj Quick Reference (For Giving to User)

**Daily Workflow:**
```bash
# Check status
jj st

# View log
jj log

# Create new commit from current changes
jj commit

# Describe/edit commit message
jj describe

# Rebase commits
jj rebase -s <revset> -d <destination>

# Push to remote (USER RUNS THIS)
jj git push
```

**Key Concepts:**
- Working copy is automatically committed
- No staging area - use `jj split` to commit partial changes
- No "current branch" - bookmarks are manual
- Operation log replaces reflog (`jj op log`, `jj undo`)

**Common Commands:**
| Task | Command |
|------|---------|
| View history | `jj log` |
| Check status | `jj st` |
| Commit changes | `jj commit` |
| Edit message | `jj describe` |
| Undo last | `jj undo` |
| Create bookmark | `jj bookmark create <name>` |
| Move bookmark | `jj bookmark set <name> -r <rev>` |
| Rebase | `jj rebase -s <rev> -d <dest>` |
| Split commit | `jj split` |
| Squash into parent | `jj squash` |
| Fetch from remote | `jj git fetch` |
| Push (USER) | `jj git push` |

**Full docs**: https://docs.jj-vcs.dev/latest/

---

**Last updated**: 2026-03-28
