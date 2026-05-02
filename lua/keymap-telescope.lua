local set = vim.keymap.set
local builtin = require 'telescope.builtin'

set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
set("n", "<leader>sls", builtin.lsp_document_symbols, { desc = "[S]earch [L]sp [S]ymbols" })

set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
