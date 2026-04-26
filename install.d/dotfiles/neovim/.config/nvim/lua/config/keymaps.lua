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

-- TMP: dump all whichkey mapps to clipboard

--
-- local function copy_leader_maps()
--   vim.schedule(function()
--     local leader = vim.mapleader or " "
--     local cmd = string.format("silent! %smap", leader)
--     local result = vim.fn.execute(cmd)
--
--     local lines = { "Leader Keymaps:" }
--     for line in result:gmatch("[^\r\n]+") do
--       if not line:match("No mapping found") and not line:match("^%-") then
--         table.insert(lines, line)
--       end
--     end
--
--     vim.fn.setreg("+", table.concat(lines, "\n"))
--     vim.notify("Leader keymaps copied to clipboard!", vim.log.levels.INFO)
--   end)
-- end
--
-- map("n", "<leader>qk", copy_leader_maps, { desc = "Copy leader keymaps to clipboard" })
