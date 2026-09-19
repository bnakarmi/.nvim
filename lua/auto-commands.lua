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
