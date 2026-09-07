return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { 'node_modules', '.git' }
            },
            pickers = {
                buffers = {
                    mappings = {
                        i = {
                            ["<C-d>"] = "delete_buffer",
                        },
                        n = {
                            ["dd"] = "delete_buffer",
                        },
                    },
                },
            },
        })
    end
}
