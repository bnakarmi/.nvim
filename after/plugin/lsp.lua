local lsp = require("lsp-zero")
local luasnip = require("luasnip")
local cmp = require("cmp")

lsp.preset("recommended")

lsp.ensure_installed({
    "cssls",
    "html",
    "jdtls",
    "lua_ls",
    "rust_analyzer",
    "svelte",
    "tsserver",
    "yamlls",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
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

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end,
    filetype = {
        {
            "dap-repl", 
            "dapui_watches", 
            "dapui_hover"
        }, {
            sources = {
                { name = "dap" }
            }
        }
    } 
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
    local core_remap = require("core.remap")

    core_remap.map_lsp_keys(bufnr)

    if client.name == "tsserver" then
        core_remap.map_ts_lsp_keys()
    end
end)

lsp.setup()

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
    signs = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
