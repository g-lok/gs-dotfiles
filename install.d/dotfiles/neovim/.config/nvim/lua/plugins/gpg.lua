vim.filetype.add({
  extension = {
    gpg = "gpg",
    asc = "asc",
  },
})

return {
  "benoror/gpg.nvim",
  ft = { "gpg", "asc", "pgp" },
}
