func! myspacevim#before() abort
    "实现一键运行
    func! QuickRun()
        " exec "w"
        let ext = expand("%:e")
        if ext ==# "sh"
            exec "!sh %"
        elseif ext ==# "md"
            exec "!dos2unix %"
            echo "DONE"
        elseif ext ==# "cpp"
            exec "!clang++ % -Wall -O3 -g -std=c++11 -o %<.out && ./%<.out"
        elseif ext ==# "c"
            exec "!clang % -Wall -g -std=c11 -o %<.out && ./%<.out"
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
            exec "!google-chrome-stable %"
        elseif ext ==# "rst"
            " FIXME
            exec "InstantRst"
        elseif ext ==# "rs"
            call CargoRun()
        else
            echo "Check file type !"
        endif
    endf

    " TODO not familiar with vimscipt, maybe better implementation
    " 1. rust project root is tag with Cargo.toml instread of VCS
    " 2. this configuration is only for project, not for single rust file
    func! CargoRun()
      let cargo_run_path = fnamemodify(resolve(expand('%:p')), ':h')
      while cargo_run_path != "/"
        if filereadable(cargo_run_path . "/Cargo.toml")
            echo cargo_run_path
            exec "cd " . cargo_run_path
            exec "!cargo run"
            exec "cd -"
            return
        endif
       let cargo_run_path = fnamemodify(cargo_run_path, ':h')
      endwhile
      echo "Cargo.toml not found !"
    endf

    " config the make run
    call SpaceVim#custom#SPC('nnoremap', ['m', 'm'], 'make -j8', 'make with 8 thread', 1)
    call SpaceVim#custom#SPC('nnoremap', ['m', 'c'], 'make clean', 'make clean', 1)
    call SpaceVim#custom#SPC('nnoremap', ['m', 'r'], 'make run', 'make run', 1)
    call SpaceVim#custom#SPC('nnoremap', ['m', 'd'], 'guigdb %', 'debug current file', 1)
    call SpaceVim#custom#SPC('nnoremap', ['s', 'f'], 'Vista finder', 'search ctags simbols', 1)
    call SpaceVim#custom#SPC('nnoremap', ['s', 'F'], 'LeaderfFunction!', 'list functions', 1)

    " TODO haven't figure out how to disable a merged plugin and free the mapp
    " https://github.com/SpaceVim/SpaceVim/issues/216
    let g:spacevim_disabled_plugins = ['nerdcommenter']
    call SpaceVim#custom#SPC('nnoremap', ['c', 'Y'], 'echo "we should disable nerdcommenter"', 'todo', 1)

    let g:mapleader = ','
    let g:spacevim_windows_leader = 'c'
    let g:spacevim_snippet_engine = 'ultisnips'

    let g:table_mode_corner='|'
    let g:rainbow_active = 1

    " If you want to start window resize mode by `Ctrl+T`
    let g:winresizer_start_key = '<space>wa'
    " If you cancel and quit window resize mode by `q` (keycode 113)
    let g:winresizer_keycode_cancel = 113

    " spell
    " https://wiki.archlinux.org/index.php/Language_checking
    
    " FIXME It disable my markdown C code highlight, and it's slow
    " let g:chromatica#enable_at_startup=1
    "
    "
    let g:spacevim_enable_vimfiler_filetypeicon = 1
    let g:spacevim_enable_vimfiler_gitstatus = 1
endf



func! myspacevim#after() abort
    au FocusLost * :wa
    au FocusGained,BufEnter * :checktime
    set autowrite
    set autoread

    " F1 F2, F3 分别为文档，tagbar和file tree
    nnoremap <F2> :Vista!!<CR>
    nnoremap <F4> :call QuickRun()<CR>

    " remap vim-commentary
    nmap <space>cl gcc
    vmap <space>cl gc
    
    let g:vista_echo_cursor_strategy = 'scroll'
    let g:vista_close_on_jump = 1
    let g:vista_sidebar_position = "vertical topleft"

    " remap the terminal
    tnoremap <Esc> <C-\><C-n>

    " maybe we don't need it
    " autocmd FileType cpp nnoremap <silent><buffer> <C-]> <Esc>:Cppman <cword><CR>
    
    let g:bookmark_auto_close = 1
    set foldmethod=syntax
    set nofoldenable

endf
