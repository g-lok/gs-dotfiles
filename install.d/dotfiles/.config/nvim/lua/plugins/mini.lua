-- Mini plugin collection
-- https://github.com/nvim-mini/mini.nvim

return {
	{
		"nvim-mini/mini.nvim",
		config = function()
			require("mini.move").setup()
			require("mini.animate").setup()
			require("mini.diff").setup()
			require("mini.align").setup()
			require("mini.operators").setup()
		end,
		version = false,
	},
}
