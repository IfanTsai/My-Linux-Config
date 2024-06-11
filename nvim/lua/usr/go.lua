require("go").setup({
  --goimports = "gopls", -- if set to 'gopls' will use golsp format
  gofmt = "gopls", -- if set to gopls will use golsp format
  --max_line_len = 120, -- only effective when gofmt is golines
  tag_transform = false,
  test_dir = "",
  comment_placeholder = "   ",
  lsp_cfg = true, -- true: apply go.nvim non-default gopls setup
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- if true, auto goimports on lsp attach
  dap_debug = true,
  dap_debug_keymap = true,
  dap_debug_gui = true,
  dap_debug_vt = true
})
