return {
	{
		{
			"snacks.nvim",
			opts = {
				scroll = { enabled = false },
				explorer = { enabled = false },
				image = { enabled = false },
			},
			keys = {
				{ "e", false },
				{ "E", false },
				{ "fe", false },
				{ "fE", false },
				{ "<leader>e", false },
				{ "<leader>E", false },
			},
		},
		{
			"folke/noice.nvim",
			opts = {
				lsp = {
					signature = {
						auto_open = {
							enabled = false,
						},
					},
				},
			},
		},
		-- {
		-- 	"saghen/blink.cmp",
		-- 	optional = true,
		-- 	opts = {
		-- 		keymap = {
		-- 			-- Disable Ctrl+E by setting it to an empty table
		-- 			["<C-e>"] = {},
		-- 		},
		-- 	},
		-- },
	},
}
