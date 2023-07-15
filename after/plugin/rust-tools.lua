local rt = require("rust-tools")

rt.setup({
    server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(_, bufnr)
            require("core.remap").map_rust_lsp_keys(bufnr)
        end
    },
    tools = {
        hover_actions = {
            auto_focus = true
        }
    }
})

