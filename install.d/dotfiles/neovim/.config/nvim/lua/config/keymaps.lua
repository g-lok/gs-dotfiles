-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help)

-- Toggle blink.cmp completion menu (insert mode)
vim.keymap.set("i", "<C-e>", function()
	local blink = require("blink.cmp")
	if blink.is_menu_visible() then
		blink.cancel()
	else
		blink.show()
	end
end, { desc = "Toggle completion menu" })

-- Toggle blink.cmp documentation (insert mode) - Ctrl+x then o
vim.keymap.set("i", "<C-x>o", function()
	local blink = require("blink.cmp")
	if blink.is_documentation_visible() then
		blink.hide_documentation()
	else
		blink.show_documentation()
	end
end, { desc = "Toggle completion documentation (Ctrl+x then o)" })
