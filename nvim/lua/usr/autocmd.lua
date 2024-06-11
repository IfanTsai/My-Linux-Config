-- highlight text when copying
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    pattern = { '*' },
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end
})

local format_sync_group = vim.api.nvim_create_augroup("format_sync", {})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_group,
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*.rs' },
  callback = function()
    vim.lsp.buf.format{ async = true }
  end,
  group = format_sync_group,
})
