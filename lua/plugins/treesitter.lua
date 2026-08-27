return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                'lua',
                'typescript',
                'javascript',
                'css',
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
                callback = function(args)
                    local disabled_fts = { html = true, yaml = true }
                    local ft = vim.bo[args.buf].filetype

                    if not disabled_fts[ft] then
                        pcall(vim.treesitter.start, args.buf)
                    end

                    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end
            })
        end
    },
    { "nvim-treesitter/nvim-treesitter-context" }
}
