local dap = require("dap")
local rt = require("rust-tools")
local mason_registry = require("mason-registry")

local codelldb = mason_registry.get_package("codelldb")
local ext_path = codelldb:get_install_path() .. "/extension/"
local codelldb_path = ext_path .. "adapter/codelldb"
local liblldb_path = ext_path .. "lldb/lib/liblldb.dylib"

rt.setup({
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
    },
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

dap.adapters.codelldb = {
    type = "server",
    host = "127.0.0.1",
    port = 13000
}

dap.configurations.rust = {
    {
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        terminal = "integrated",
        sourceLanguages = { "rust" }
    }
}
