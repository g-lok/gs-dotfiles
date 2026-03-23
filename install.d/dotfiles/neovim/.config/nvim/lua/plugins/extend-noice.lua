return {
    {
        "folke/noice.nvim",
        dependencies = { "rcarriga/nvim-notify" },
        opts = {
            views = {
                popup = {
                    border = { style = "rounded" },
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
            routes = {},
        },
    },
}
