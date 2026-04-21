-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Treat empty buffers in memory as markdown
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("lazyvim_empty_md", { clear = true }),
  pattern = { "*" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[buf].filetype
    local has_text = #vim.api.nvim_buf_get_lines(buf, 0, -1, false) > 0

    -- If buffer is empty and no filetype is set, set it to markdown
    -- Ignore opencode terminal buffers which cause marksman to crash
    if
      (filetype == "" or filetype == nil)
      and not has_text
      and not vim.api.nvim_buf_get_name(buf):match("opencode")
    then
      vim.bo[buf].filetype = "markdown"
    end
  end,
})
