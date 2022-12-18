vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")
local luasnip = require("luasnip")
local snippets = require("luasnip.loaders.from_vscode")

luasnip.config.set_config({ region_check_events = "InsertEnter" })

snippets.lazy_load()
snippets.load({ include = { vim.bo.filetype } })

local select_opts = { behavior = cmp.SelectBehavior.Select }
local check_back_space = function()
  local col = vim.fn.col(".") - 1

  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

cmp.setup(
  {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = "[LSP]",
          nvim_lua = "[api]",
          luasnip = "[snip]",
          buffer = "[buf]",
          path = "[path]"
        }

        item.menu = menu_icon[entry.source.name]

        return item
      end
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert(
      {
        -- Select Previous item
        ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        -- Selct Next item
        ["<Down>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
        -- Scroll Back
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        -- Scroll Forward
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        -- Jump Down
        ["<C-d>"] = cmp.mapping(
          function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end,
          { "i", "s" }
        ),
        -- Jump Up
        ["<C-u>"] = cmp.mapping(
          function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          { "i", "s" }
        ),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            local col = vim.fn.col(".") - 0

            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif check_back_space() then
              fallback()
            else
              cmp.complete()
            end
          end,
          { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            else
              fallback()
            end
          end,
          { "i", "s" }
        )
      }
    ),
    sources = cmp.config.sources(
      {
        { name = "nvim_lua" },
        { name = "nvim_lsp", keyword_length = 2, max_item_count = 8 },
        { name = "path" },
        { name = "luasnip", keyword_length = 2, max_item_count = 8 }
      },
      {
        { name = "buffer", keyword_length = 2, max_item_count = 8 }
      }
    )
  }
)

-- Set configuration for specific filetype.
cmp.setup.filetype(
  "gitcommit",
  {
    sources = cmp.config.sources(
      {
        { name = "cmp_git" } -- You can specify the `cmp_git` source if you were installed it.
      },
      {
        { name = "buffer" }
      }
    )
  }
)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  "/",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" }
    }
  }
)

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(
  ":",
  {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      {
        { name = "path" }
      },
      {
        { name = "cmdline" }
      }
    )
  }
)

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = 'rounded' }
)
