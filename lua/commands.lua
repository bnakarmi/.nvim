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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  desc = "Quickfix list window keymaps",
  callback = function(event)
    local idx = vim.fn.line(".")

    vim.keymap.set("n", "<C-v>", function()
      vim.cmd("wincmd p")  -- switch to the previous editing window
      vim.cmd("vsplit")    -- create vertical split
      vim.cmd(idx .. "cc") -- open the selected quickfix entry
    end, { buffer = event.buf, desc = "Open item in vertical split" })

    vim.keymap.set("n", "<C-x>", function()
      vim.cmd("wincmd p")
      vim.cmd("split")
      vim.cmd(idx .. "cc")
    end, { buffer = event.buf, desc = "Open item in horizontal split" })

    vim.keymap.set("n", "<C-t>", function()
      vim.cmd("wincmd p")
      vim.cmd("tabedit")
      vim.cmd(idx .. "cc")
    end, { buffer = event.buf, desc = "Open item in new tab" })
  end,
})
