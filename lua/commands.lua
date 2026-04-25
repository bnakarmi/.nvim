-- Close all hidden buffers
vim.api.nvim_create_user_command("BufOnly", function(opts)
    local keep = {}
    local deleted = 0

    -- Keep every buffer currently visible in any window of any tab
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
            local buf = vim.api.nvim_win_get_buf(win)
            keep[buf] = true
        end
    end

    -- Delete all listed, hidden, non-terminal buffers
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not keep[buf] then
            if vim.bo[buf].buftype ~= "terminal" then
                local ok = pcall(vim.api.nvim_buf_delete, buf, {
                    force = opts.bang,
                })
                if ok then
                    deleted = deleted + 1
                end
            end
        end
    end

    vim.notify(("BufOnly: deleted %d buffer(s)"):format(deleted))
end, {
    bang = true,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
