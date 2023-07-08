local util = require "lspconfig/util"

return {
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      usePlaceholders = true,
			semanticTokens = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
