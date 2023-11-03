syntax enable
" 鼠标可以移动，调整窗口等
set mouse=a
" 超过 window 宽度的行不要折叠
set nowrap
" 自动进入到新打开的窗口
set splitbelow
set splitright
" 打开行号
set number
" 高亮光标所在行
set cursorline
set cursorcolumn                        " 显示当前列
set nobackup                            " 不创建备份文件
set noswapfile                          " 不生成临时文件
set nowritebackup                       " 编辑的时候不需要备份文件

set termguicolors
" 因为失去焦点就会自动保存，所以没有必要使用 swapfile
set noswapfile
" 自动隐藏 command-line
set cmdheight=0
" 让退出 vim 之后 undo 消息不消失
set undofile
" 只有一个全局的 status line，而不是每一个 window 一个
set laststatus=3
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
" 关闭模式行
set nomodeline

" 当打开文件的时候，自动进入到上一次编辑的位置
lua vim.api.nvim_create_autocmd( "BufReadPost", { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] })
" 当文件被其他编辑器修改时，自动加载
set autoread
au FocusGained,BufEnter * :checktime
" 当失去焦点或者离开当前的 buffer 的时候保存
set autowrite
autocmd FocusLost,BufLeave * silent! update

" 在 terminal 中也是使用 esc 来进入 normal 模式
tnoremap  <Esc>  <C-\><C-n>
" 映射 leader 键为 ,
let g:mapleader = ','
" 将jj 映射为esc
inoremap jj <esc>
" 使用 vv 选中当前行
nnoremap vv ^vg_
" 使用 Ctrl+a 将当前单词转成大写
nmap <C-a> gUiwe
imap <C-a> <esc>gUiwgi
" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" use ctrl+s sudo to save
nnoremap <C-s> :w !sudo tee %<cr>
" 一键清理代码行尾的空格
nnoremap cc :%s/\s\+$//<cr>:let @/=''<CR>

" 将 q 映射为 <leader>q，因为录制宏的操作比较少，而关掉窗口的操作非常频繁
noremap <leader>q q

" 访问系统剪切板
"map <leader>y "+y
"map <leader>p "+p
"map <leader>d "+d

" always copy and paster use system clipboard
set clipboard+=unnamedplus

" 使用 z a 打开和关闭 fold ，打开大文件（超过 10 万行）的时候可能造成性能问题
" set foldlevelstart=99
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" floaterm 功能很强大，但是性能不行，
" 如果执行的命令存在大量输出，可能卡死整个 nvim
let g:floaterm_width = 0.7
let g:floaterm_height = 0.7
let g:floaterm_keymap_prev   = '<C-p>'
let g:floaterm_keymap_new    = '<C-n>'
let g:floaterm_keymap_toggle = '<C-t>'

" 加载 lua 配置
lua require 'usr'

" 加载 vim 配置, 参考 https://github.com/jdhao/nvim-config
let s:core_conf_files = [
      \ 'misc.vim',
      \ 'debug.vim',
      \ 'wilder.vim',
      \ 'haskell.vim',
      \ ]

for s:fname in s:core_conf_files
  execute printf('source %s/vim/%s', stdpath('config'), s:fname)
endfor

colorscheme tokyonight-night
let g:loaded_perl_provider = 0

" this keymapping originally set by whichkey doesn't work in neovim 0.8
noremap <Space>bc :BDelete hidden<cr>

let g:gitblame_delay = 1500
let g:gitblame_ignored_filetypes = ['lua', 'markdown', 'sh']

" 因为 nvim-treesitter-textobjects 使用 x 来跳转，原始的 x 被映射为 xx
nn xx x
