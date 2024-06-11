require("usr.options")
require("usr.lazy")
require("usr.lsp")
require("usr.go")
require("usr.cmp")
require("usr.bufferline")
require("usr.code_runner")
require("usr.hydra")
require("usr.nvim-tree")
require("usr.nvim-treesitter")
require("usr.orgmode")
require("usr.telescope")
require("usr.version")
require("usr.which-key")
require("usr.colorscheme")
require("usr.autocmd")
require("usr.alpha")
require("colorizer").setup({
    "css",
    "javascript",
    "vim",
    html = {
        mode = "foreground"
    }
})
require("nvim-surround").setup()
require("gitsigns").setup({
    signs = {
        add = {
            text = '+'
        },
        change = {
            text = '│'
        },
        delete = {
            text = '_'
        },
        topdelete = {
            text = '‾'
        },
        changedelete = {
            text = '~'
        },
        untracked = {
            text = '┆'
        }
    },
    signcolumn = true,
    numhl = true,
    current_line_blame = true,
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false
    }
})
require("leap").add_default_mappings()
require("nvim-autopairs").setup()
require("fidget").setup()
require("nvim-navic").setup()
require("barbecue").setup()
require("nvim-lightbulb").update_lightbulb()
require("im_select").setup()
require("lualine").setup()
require("rsync").setup()
require("numb").setup()
require("debugprint").setup()
-- require("hardtime").setup() # 一时难以适应

-- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/" })
require("luasnip.loaders.from_snipmate").lazy_load({
    paths = "~/.config/nvim/snippets/"
})
-- require("luasnip.loaders.from_vscode").load({paths = "~/.config/nvim/snippets"})

-- workaround for https://github.com/neovim/neovim/issues/21856
vim.api.nvim_create_autocmd({"VimLeave"}, {
    callback = function()
        vim.cmd("sleep 10m")
    end
})

-- 导航栏
require("aerial").setup({
    backends = {"markdown", "man", "lsp", "treesitter"},
    layout = {
        max_width = {30, 0.15},
        width = 0.2,
        placement = "edge",
        default_direction = "right"
    },
    attach_mode = "global"
})

-- 书签
require("bookmarks").setup({
  mappings_enabled = false,
  virt_pattern = { "*.lua", "*.md", "*.c", "*.h", "*.sh", "*.py" },
})
