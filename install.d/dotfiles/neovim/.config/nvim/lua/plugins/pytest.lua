return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/neotest-python",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		adapters = {
			["neotest-python"] = {
				runner = "pytest",
				-- Optional: specify Python interpreter if needed
				-- python = ".venv/bin/python",
				python = "./.venv/bin/python", -- Adjust path to your venv
				args = { "--capture=no" },
				pytest_discover_instances = true,
			},
		},
	},
}
