local function focus_opencode()
	vim.schedule(function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local buf = vim.api.nvim_win_get_buf(win)
			if vim.api.nvim_buf_get_name(buf):match("opencode %-%-port") then
				vim.api.nvim_set_current_win(win)
				return true
			end
		end
	end)
	return false
end

return {
	{
		"Nickvandyke/opencode.nvim",
		version = "*",
		dependencies = {
		{
			"folke/snacks.nvim",
			optional = true,
			opts = function(_, opts)
			end,
		},
			{
				"folke/which-key.nvim",
				opts = {
					spec = {
						{ "<leader>a", mode = { "n", "x" }, group = "OpenCode" },
						{ "<leader>ap", mode = { "n", "x" }, group = "Prompt" },
					},
				},
			},
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {}
			vim.o.autoread = true

			-- On window focus
			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = "*:opencode --port*",
				callback = function()
					vim.cmd("startinsert")
				end,
			})

			-- On first open
			vim.api.nvim_create_autocmd({ "TermOpen" }, {
				group = vim.api.nvim_create_augroup("opencode_integrated", { clear = true }),
				pattern = "*:opencode --port*",
				callback = function(event)
					-- Hide from bufferline/tabs
					vim.bo[event.buf].buflisted = false

					-- LOCAL BINDS: Only active within the OpenCode buffer
					require("which-key").add({
						buffer = event.buf,
						mode = { "t", "n" },
						-- Navigation (Local to this terminal only)
						{ "<C-h>", [[<C-\><C-n><C-w>h]], desc = "Go to Left Window" },
						{ "<C-j>", [[<C-\><C-n><C-w>j]], desc = "Go to Lower Window" },
						{ "<C-k>", [[<C-\><C-n><C-w>k]], desc = "Go to Upper Window" },
						{ "<C-l>", [[<C-\><C-n><C-w>l]], desc = "Go to Right Window" },
						-- Scrolling
						{
							"<C-U>",
							function()
								require("opencode").command("session.half.page.up")
							end,
							desc = "Half scroll back",
						},
						{
							"<C-D>",
							function()
								require("opencode").command("session.half.page.down")
							end,
							desc = "Half scroll forward",
						},
						{
							"<C-B>",
							function()
								require("opencode").command("session.page.up")
							end,
							desc = "Scroll backward",
						},
						{
							"<C-F>",
							function()
								require("opencode").command("session.page.down")
							end,
							desc = "Scroll forward",
						},
					})
				end,
			})

			-- Opencode always stop on quit
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					-- Force kill child processes (Linux/Unix)
					if vim.fn.has("unix") == 1 then
						local pid = vim.fn.getpid()
						vim.fn.system({ "pkill", "-P", tostring(pid), "-f", "opencode" })
					end
				end,
			})
		end,
		keys = {
			{
				"<leader>aa",
				function()
					require("opencode").toggle()
					focus_opencode()
				end,
				mode = { "n", "t" },
				desc = "Toggle",
			},
			{
				"<leader>aq",
				function()
					require("opencode").stop()
				end,
				mode = { "n", "t" },
				desc = "Stop/Close",
			},
			{
				"<leader>as",
				function()
					require("opencode").select()
				end,
				mode = { "n", "x" },
				desc = "Select action",
			},
			{
				"<leader>ai",
				function()
					require("opencode").ask("", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask",
			},
			{
				"<leader>aI",
				function()
					require("opencode").ask("@this: ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask with context",
			},
			{
				"<leader>ab",
				function()
					require("opencode").ask("@file: ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask about buffer",
			},
			{
				"<leader>ape",
				function()
					require("opencode").prompt("explain", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Explain",
			},
			{
				"<leader>apf",
				function()
					require("opencode").prompt("fix", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Fix",
			},
			{
				"<leader>apd",
				function()
					require("opencode").prompt("diagnose", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Diagnose",
			},
			{
				"<leader>apr",
				function()
					require("opencode").prompt("review", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Review",
			},
			{
				"<leader>apt",
				function()
					require("opencode").prompt("test", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Test",
			},
			{
				"<leader>apo",
				function()
					require("opencode").prompt("optimize", { submit = true })
				end,
				mode = { "n", "x" },
				desc = "Optimize",
			},
			{
				"go",
				function()
					return require("opencode").operator("@this ")
				end,
				expr = true,
				mode = { "n", "x" },
				desc = "Add range to OpenCode",
			},
			{
				"goo",
				function()
					return require("opencode").operator("@this ") .. "_"
				end,
				expr = true,
				mode = { "n" },
				desc = "Add line to OpenCode",
			},
		},
	},
}
