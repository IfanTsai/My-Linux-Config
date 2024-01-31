require('tokyonight').setup({
  style = 'night',
   on_colors = function(colors)
     colors.terminal_black = "#7989a9"
  end
})

vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "grey" }) -- leap.nvim
vim.cmd.colorscheme 'tokyonight'
