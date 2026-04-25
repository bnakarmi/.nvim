return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { 'node_modules' }
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
