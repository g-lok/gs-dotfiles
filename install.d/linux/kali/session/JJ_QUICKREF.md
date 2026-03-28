# Jujutsu (jj) Quick Reference

**⚠️ AI: Never run `jj git *` commands - only give instructions to user**

**How to detect jj repo:** Look for `.jj/` folder in current directory or ancestors.

---

## Key Differences from Git

| Git | Jujutsu |
|-----|---------|
| Staging area (git add) | No staging - use `jj split` |
| Branch is current | No "current branch" - use bookmarks |
| Detached HEAD is special | Normal state (no bookmark) |
| git rebase | jj rebase (auto-rebases children) |
| git commit | jj commit |
| git push | jj git push (USER runs) |
| git log | jj log |

---

## Daily Commands

```bash
# Check what's changed
jj st
jj status

# View history
jj log
jj log --revsets main..     # what's on main but not in your commits

# Commit (auto-snapshot working copy)
jj commit
jj describe                 # edit commit message

# Move commits around
jj rebase -s @ -d main     # rebase current stack onto main

# Undo (powerful - undo any operation)
jj undo
jj op log                  # see operation history
```

---

## Working with Bookmarks (like branches)

```bash
# Create bookmark
jj bookmark create mywork

# Move bookmark
jj bookmark set mywork -r @

# List bookmarks
jj bookmark list
jj b list
```

---

## Partial Commits (instead of staging)

```bash
# Split current commit into two
jj split

# Squash changes into parent
jj squash

# Move all changes from this commit to its parent
jj squash -s @
```

---

## Remote Operations (USER RUNS)

```bash
# Fetch updates
jj git fetch

# Push to remote
jj git push

# Pull + rebase onto updated
jj git pull --rebase
```

---

## Important Concepts

1. **Working copy is a commit** - always tracked, automatically snapshot
2. **No index** - use `jj split` for partial commits
3. **Auto-rebase** - rewriting any commit rebases all descendants
4. **Operation log** - instead of reflog, tracks ALL changes atomically
5. **Conflicts can be committed** - no failed commands due to conflicts

---

## Revset Examples

```bash
jj log -r @            # current commit
jj log -r @-          # parent of current
jj log -r main..      # commits after main
jj log -r "heads(bookmarks())"  # all bookmark tips
```

---

## Help

```bash
jj help
jj help <command>     # e.g., jj help rebase
jj help -k tutorial
```

**Docs**: https://docs.jj-vcs.dev/latest/
