set termguicolors
" TMP_TODO 这个配置的位置需要改动吗?
lua require('lua-init')
" 当文件被其他编辑器修改时，自动加载
set autoread
au FocusGained,BufEnter * :checktime
" 当失去焦点或者离开当前的 buffer 的时候保存
set autowrite
autocmd FocusLost,BufLeave * silent! update

" 重新映射 leader 键
let g:mapleader = ','
" 重新映射 window 键位
" TMP_TODO
" let g:spacevim_windows_leader = 'c'

" 在 markdown 中间编辑 table
let g:table_mode_corner='|'

" 调节 window 大小
let g:winresizer_start_key = '<space>wa'
" If you cancel and quit window resize mode by `q` (keycode 113)
let g:winresizer_keycode_cancel = 113

" 默认 markdown preview 在切换到其他的 buffer 或者 vim
" 失去焦点的时候会自动关闭 preview，让
let g:mkdp_auto_close = 0
" 书签选中之后自动关闭 quickfix window
let g:bookmark_auto_close = 1

" ctrl + ] 查询 cppman
" 如果想让该快捷键自动查询 man，将Cppman 替换为 Cppman!
autocmd FileType c,cpp noremap <C-]> <Esc>:execute "Cppman " . expand("<cword>")<CR>

" 让光标自动进入到popup window 中间
let g:git_messenger_always_into_popup = v:true

" 和 sourcetrail 配合使用
" TMP_TODO
" call SpaceVim#custom#SPC('nnoremap', ['a', 'a'], 'SourcetrailStartServer', 'start sourcetrail server', 1)
" call SpaceVim#custom#SPC('nnoremap', ['a', 'b'], 'SourcetrailActivateToken', 'sync sourcetrail with neovim', 1)
" call SpaceVim#custom#SPC('nnoremap', ['a', 'f'], 'SourcetrailRefresh', 'sourcetrail server', 1)

" 多文件的搜索替换
" TMP_TODO
" call SpaceVim#custom#SPC('nnoremap', ['s', 'v'], "lua require('spectre').open()", 'search and replace in multiple files', 1)
"
" TMP_TODO
" call SpaceVim#custom#SPC('nnoremap', ['f', 'o'], "NvimTreeFindFile", 'find current file in file tree', 2)

" 设置默认的 pdf 阅览工具
let g:vimtex_view_method = 'zathura'
let g:vimtex_syntax_conceal_default = 0
let g:tex_conceal = "" " 关闭所有隐藏设置

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    retab
endfun
command! TrimWhitespace call TrimWhitespace()

" 实现一键运行各种文件，适合非交互式的，少量的代码，比如 leetcode
func! QuickRun()
  exec "w"
  let ext = expand("%:e")

  if ext ==# "sh"
    exec "!bash %"
  elseif ext ==# "cpp"
    let out = expand('%:p') . ".out"
    exec "!clang++ % -Wall -lpthread -g -std=c++17 -o " . out . " && " . out
  elseif ext ==# "c"
    let out = expand('%:p') . ".out"
    exec "!clang % -Wall -lpthread -g -std=c11 -o " . out . " && " . out
  elseif ext ==# "java"
    let classPath = expand('%:h')
    let className = expand('%:p:t:r')
    " echo classPath
    " echo className
    exec "!javac %"
    exec "!java -classpath " . classPath . " " . className
  elseif ext ==# "go"
    exec "!go run %"
  elseif ext ==# "js"
    exec "!node %"
  elseif ext ==# "bin"
    exec "!readelf -h %"
  elseif ext ==# "py"
    exec "!python3 %"
  elseif ext ==# "vim"
    exec "so %"
  elseif ext ==# "html"
    exec "!microsoft-edge %"
  elseif ext ==# "md"
    exec "MarkdownPreview"
  elseif ext ==# "rs"
    exec "CocCommand rust-analyzer.run"
  elseif ext ==# "svg"
    exec "%!xmllint --format -"
  elseif ext ==# "lua"
    exec "source %"
  else
    echo "Check file type !"
  endif
endf

" floaterm
let g:floaterm_keymap_prev   = '<C-p>'
let g:floaterm_keymap_new    = '<C-n>'
let g:floaterm_keymap_toggle = '<F5>'


" 主题颜色
colorscheme tokyonight
" colorscheme gruvbox

" <F3> 打开文件树
let g:vista_sidebar_position = "vertical topleft"
let g:vista_default_executive = 'coc'
let g:vista_finder_alternative_executives = 'ctags'
nnoremap <F2>  :Vista!!<CR>
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
nnoremap <F3>  :NvimTreeToggle<CR>
nnoremap <F4>  :call QuickRun()<CR>
" <F5> floaterm toggle
" <F7> 打开历史记录
" 在 terminal 中也是使用 esc 来进入 normal 模式
tnoremap  <Esc>  <C-\><C-n>

" 使用 tab 切换到下一个 window
map <Tab> :wincmd w<CR>
" 使用 space [number] 切换到第 [number] 个 window
nnoremap <silent> <space>1 :1wincmd  w <cr>
nnoremap <silent> <space>2 :2wincmd  w <cr>
nnoremap <silent> <space>3 :3wincmd  w <cr>
nnoremap <silent> <space>4 :4wincmd  w <cr>
nnoremap <silent> <space>5 :5wincmd  w <cr>
nnoremap <silent> <space>6 :6wincmd  w <cr>
nnoremap <silent> <space>7 :7wincmd  w <cr>
nnoremap <silent> <space>8 :8wincmd  w <cr>
nnoremap <silent> <space>9 :9wincmd  w <cr>
nnoremap <silent> <space>0 :10wincmd w <cr>

" 使用 <leader> [number] 切换到第 [number] 个 buffer
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>

" 使用 f/F 来快速移动
" press <esc> to cancel.
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap ; <Plug>(coc-smartf-repeat)
nmap , <Plug>(coc-smartf-repeat-opposite)

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=pink
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
augroup end

" 显示当前行的详细信息
nmap <space>gm  <Cmd>GitMessenger<CR>
" 以 floaterm 的方式打开 tig
nmap <space>gs  <Cmd>FloatermNew tig status<CR>
" 在左侧显示 git blame
nmap <space>gb  <Cmd>Git blame<CR>
nmap <space>gc  <Cmd>Git commit<CR>
nmap <space>gl  <Cmd>FloatermNew tig %<CR>
nmap <space>gL  <Cmd>FloatermNew tig<CR>
nmap <space>gp  <Cmd>Git push<CR>

" 瞬间呼出 ipython 来计算
nmap <space>x  <Cmd>FloatermNew ipython<CR>
nmap <space>bc  <Cmd>BWipeout other<CR>

" 注释代码和取消注释
nmap <space>c  :Commentary<CR>
vmap <space>c  :Commentary<CR>

nmap q <Cmd>q<CR>

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' :'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'
let g:airline_theme="atomic"

" TMP_TODO so, the snippet can be loaded?

" TMP_TODO 这个配置需要重新分析一下
" let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#coc#show_coc_status = 1