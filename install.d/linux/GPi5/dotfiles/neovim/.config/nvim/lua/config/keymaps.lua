-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- Toggle signature help in insert mode (hidden by default)
map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Toggle Signature Help" })

-- Toggle blink.cmp completion menu (insert mode)
map("i", "<C-e>", function()
  local blink = require("blink.cmp")
  if blink.is_menu_visible() then
    blink.cancel()
  else
    blink.show()
  end
end, { desc = "Toggle completion menu" })

-- Toggle blink.cmp documentation (insert mode) - Ctrl+x then o
map("i", "<C-x>o", function()
  local blink = require("blink.cmp")
  if blink.is_documentation_visible() then
    blink.hide_documentation()
  else
    blink.show_documentation()
  end
end, { desc = "Toggle completion documentation (Ctrl+x then o)" })

-- Dump all which-key keymappings to local buffer
map("n", "<leader>bk", function()
  local buffer = require("snacks.picker").keymaps()
  -- The picker opens in a buffer, but to dump to a specific buffer,
  -- you may need to iterate the picker's results or use which-key directly.
  -- Alternatively, use which-key to show a list:
  -- require("which-key").show({ global = true })
end, { desc = "Dump all keymaps to local buffer" })
