local lsp = require("lsp-zero")
local luasnip = require("luasnip")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

lsp.preset("recommended")

lsp.ensure_installed({
    "angularls",
    "cssls",
    "dartls",
    "html",
    "omnisharp",
    "rust_analyzer",
    "sumneko_lua",
    "svelte",
    "tsserver",
    "yamlls",
})

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

local check_back_space = function()
    local col = vim.fn.col(".") - 1

    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    -- Select Previous item
    ["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    -- Selct Next item
    ["<Down>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    -- Scroll Back
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    -- Scroll Forward
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- Jump Down
    ["<C-d>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
    end, { "i", "s" }),
    -- Jump Up
    ["<C-u>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
        local col = vim.fn.col(".") - 0

        if cmp.visible() then
            cmp.select_next_item(cmp_select)
        elseif check_back_space() then
            fallback()
        else
            cmp.complete()
        end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item(cmp_select)
        else
            fallback()
        end
    end, { "i", "s" }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

lsp.on_attach(function(client, bufnr)
    local bufmap = function(mode, lhs, rhs)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set(mode, lhs, rhs, opts)
    end

    local organize_imports = function()
        local buf_nr = vim.api.nvim_get_current_buf()

        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(buf_nr) },
            title = "Organize imports",
        }

        vim.lsp.buf.execute_command(params)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>")

    -- Jump to the definition
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")

    -- Jump to declaration
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

    -- Lists all the implementations for the symbol under the cursor
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")

    -- Jumps to the definition of the type symbol
    bufmap("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

    -- Lists all the references
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")

    -- Displays a function's signature information
    bufmap("n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

    -- Organize imports
    bufmap("n", "<leader>oi", organize_imports)

    -- Renames all references to the symbol under the cursor
    bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")

    -- Selects a code action available at the current cursor position
    bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    bufmap("x", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")

    -- Show diagnostics in a floating window
    bufmap("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<cr>")

    -- Move to the previous diagnostic
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

    -- Move to the next diagnostic
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
end)

lsp.setup()

-- Insert `(` after select function or method item
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
