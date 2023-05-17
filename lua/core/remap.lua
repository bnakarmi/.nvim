-- START::Global keymaps
vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Format
vim.keymap.set("n", "<leader>f", ":Format<CR>")

-- NerdTree
vim.keymap.set("n", "<leader>eo", "<cmd>NERDTreeFind<CR>", { desc = "[E]xplorer [O]pen" })
vim.keymap.set("n", "<leader>ec", "<cmd>NERDTreeClose<CR>", { desc = "[E]xplorer [C]lose" })
vim.keymap.set("n", "<leader>cb", "<cmd>BufOnly<CR>")

-- Telescope
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "[T]erminal [C]lose" })
-- END::Global keymaps

local M = {}

local key_map = function(mode, lhs, rhs, bufnr, desc)
    local opts = { buffer = bufnr, remap = false }

    if desc ~= nil then
        opts["desc"] = desc
    end

    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.map_lsp_keys(bufnr)
    key_map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", bufnr, "[L]sp [H]elp")
    key_map("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", bufnr, "[L]sp [D]efinition")
    key_map("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", bufnr, "[L]sp [D]eclaration")
    key_map("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", bufnr, "[L]sp [I]mplementation")
    key_map("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", bufnr, "[L]sp [T]ype Definition")
    key_map("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<cr>", bufnr, "[L]sp [R]eferences")
    key_map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", bufnr, "[L]sp [H]elp")
    key_map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", bufnr, "[L]sp [R]eferences")
    key_map("n", "<leader>lc", "<cmd>lua vim.lsp.buf.code_action()<cr>", bufnr, "[L]sp [A]ctions")
    key_map("x", "<leader>lc", "<cmd>lua vim.lsp.buf.range_code_action()<cr>", bufnr, "[L]sp [A]ctions")
    key_map("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<cr>", bufnr, "[L] [D]iagnostic")
    key_map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", bufnr, "[P]revious [D]iagnostic")
    key_map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", bufnr, "[N]ext [D]iagnostic")
end

function M.map_java_lsp_keys(bufnr)
    local java_utils = require("utils.java")

    M.map_lsp_keys(bufnr)
    M.map_debug_keys()

    -- Java specific keymaps
    key_map("n", "<leader>lo", ":lua require('jdtls').organize_imports()<CR>", bufnr, "[O]rganize [I]mports")
    -- Run
    key_map("n", "<leader><F9>", function() java_utils.run_spring_boot() end)
    -- Debug
    key_map("n", "<leader><F10>", function() java_utils.run_spring_boot(true) end)
    -- Attach debugger
    key_map("n", "<leader>da", function() java_utils.attach_to_debug() end)
end

function M.map_ts_lsp_keys()
    local buf_nr = vim.api.nvim_get_current_buf()

    local organize_ts_imports = function()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(buf_nr) },
            title = "Organize imports",
        }

        vim.lsp.buf.execute_command(params)
    end

    -- Organize imports
    vim.keymap.set(
        "n",
        "<leader>lo",
        organize_ts_imports,
        { buffer = buf_nr, remap = false, desc = "[O]rganize [I]mports - Typescript" }
    )
end

function M.map_rust_lsp_keys(bufnr)
    M.map_lsp_keys(bufnr)

    local rt = require("rust-tools")

    vim.keymap.set(
        "n",
        "<leader>lh",
        rt.hover_actions.hover_actions,
        {
            buffer = bufnr,
            desc = "[L]SP [H]over"
        }
    )

    vim.keymap.set(
        "n",
        "<leader>lc",
        rt.code_action_group.code_action_group,
        {
            buffer = bufnr,
            desc = "[L]SP [C]ode [A]ction"
        }
    )
end

function M.map_debug_keys()
    vim.keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "[D]ebug [R]un to Cursor" })
    vim.keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
        { desc = "[D]ebug [E]valuate Input" })
    vim.keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
        { desc = "[D]ebug [C]onditional Breakpoint" })
    vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "[D]ebug [T]oggle UI" })
    vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", { desc = "[D]ebug [S]tep Back" })
    vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebug [C]ontinue" })
    vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { desc = "[D]ebug [D]isconnect" })
    vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
    vim.keymap.set("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", { desc = "[D]ebug [G]et Session" })
    vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>",
        { desc = "[D]ebug [H]over Variables" })
    vim.keymap.set("n", "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = "[D]ebug [S]copes" })
    vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "[D]ebug [S]tep Into" })
    vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "[D]ebug [S]tep Over" })
    vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = "[D]ebug [P]ause" })
    vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { desc = "[D]ebug [Q]uit" })
    vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "[D]ebug [T]oggle Repl" })
    vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebug [S]tart" })
    vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        { desc = "[D]ebug [T]oggle Breakpoint" })
    vim.keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { desc = "[D]ebug [T]erminate" })
    vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { desc = "[D]ebug [S]tep Out" })
    vim.keymap.set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
end

return M
