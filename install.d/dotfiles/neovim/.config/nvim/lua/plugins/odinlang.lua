return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ols = {
          -- Set to false if you installed ols via Mason to avoid conflicts
          -- mason = false,

          -- Optional: Specify explicit path if not in PATH
          -- cmd = { "/path/to/ols" },

          -- Optional: Specify Odin compiler path if not in PATH
          -- settings = {
          --   odin_command = "/path/to/odin",
          -- },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        odin = { "odinfmt" },
      },
      formatters = {
        odinfmt = {
          command = "odinfmt",
          args = { "-stdin" },
          stdin = true,
        },
      },
    },
  },
}
