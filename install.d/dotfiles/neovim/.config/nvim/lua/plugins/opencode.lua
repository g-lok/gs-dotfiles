local function safe_ask(prompt, opts)
	if not vim.fn.executable("opencode") then
		vim.notify("opencode: binary not installed. See opencode.ai", vim.log.levels.ERROR)
		return
	end
	require("opencode").ask(prompt, opts)
end

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
		cmd = "OpenCode",
		keys = {
			{ "gO", false },

			{
				"<leader>aa",
				function()
					require("opencode").toggle()
					focus_opencode()
				end,
				mode = { "n", "t" },
				desc = "Toggle OpenCode",
			},

			{
				"<leader>aq",
				function()
					require("opencode").stop()
				end,
				mode = { "n", "t" },
				desc = "Stop/Close OpenCode",
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
					safe_ask("", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask (empty)",
			},

			{
				"<leader>aI",
				function()
					safe_ask("@this: ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask with context",
			},

			{
				"<leader>ab",
				function()
					safe_ask("@buffer ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask about buffer",
			},

			{
				"<leader>aY",
				function()
					safe_ask("@clipboard ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask with clipboard",
			},

			{
				"<leader>aP",
				function()
					safe_ask("@diff ", { submit = true, focus = false })
				end,
				mode = { "n", "x" },
				desc = "Ask with diff",
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
				"<leader>an",
				function()
					require("opencode").command("session.new")
				end,
				mode = { "n" },
				desc = "New session",
			},

			{
				"<leader>ax",
				function()
					require("opencode").command("session.close")
				end,
				mode = { "n" },
				desc = "Close session",
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
		config = function()
			vim.g.opencode_opts = {}

			vim.api.nvim_create_autocmd({ "BufEnter" }, {
				pattern = "*:opencode --port*",
				callback = function()
					vim.cmd("startinsert")
				end,
			})

			vim.api.nvim_create_autocmd({ "TermOpen" }, {
				group = vim.api.nvim_create_augroup("opencode_integrated", { clear = true }),
				pattern = "*:opencode --port*",
				callback = function(event)
					vim.bo[event.buf].buflisted = false

					vim.keymap.set(
						{ "t", "n" },
						"<C-h>",
						"<C-\\><C-n><C-w>h",
						{ buffer = event.buf, desc = "Go to Left Window" }
					)
					vim.keymap.set(
						{ "t", "n" },
						"<C-j>",
						"<C-\\><C-n><C-w>j",
						{ buffer = event.buf, desc = "Go to Lower Window" }
					)
					vim.keymap.set(
						{ "t", "n" },
						"<C-k>",
						"<C-\\><C-n><C-w>k",
						{ buffer = event.buf, desc = "Go to Upper Window" }
					)
					vim.keymap.set(
						{ "t", "n" },
						"<C-l>",
						"<C-\\><C-n><C-w>l",
						{ buffer = event.buf, desc = "Go to Right Window" }
					)
					vim.keymap.set("t", "<C-U>", function()
						require("opencode").command("session.half.page.up")
					end, { buffer = event.buf, desc = "Half scroll back" })
					vim.keymap.set("t", "<C-D>", function()
						require("opencode").command("session.half.page.down")
					end, { buffer = event.buf, desc = "Half scroll forward" })
					vim.keymap.set("t", "<C-B>", function()
						require("opencode").command("session.page.up")
					end, { buffer = event.buf, desc = "Scroll backward" })
					vim.keymap.set("t", "<C-F>", function()
						require("opencode").command("session.page.down")
					end, { buffer = event.buf, desc = "Scroll forward" })
				end,
			})

			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					if vim.fn.has("unix") == 1 then
						local pid = vim.fn.getpid()
						vim.fn.system({ "pkill", "-P", tostring(pid), "-f", "opencode" })
					end
				end,
			})
		end,
	},
}
