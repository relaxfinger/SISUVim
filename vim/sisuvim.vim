let mapleader = ' '
let maplocalleader = '\\'

set nocompatible
set background=dark
set number
set cursorline
set mouse=a
set hidden
set ignorecase
set smartcase
set incsearch
set hlsearch
set splitright
set splitbelow
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set nowrap
set scrolloff=3
set sidescrolloff=3
set undofile
set laststatus=2
set showtabline=2
set noshowmode
set signcolumn=yes
set cursorlineopt=number,line
set fillchars=vert:│,fold:·,foldopen:⌄,foldclose:›
syntax enable

if has('clipboard')
  set clipboard+=unnamedplus
endif

if exists('+termguicolors')
  set termguicolors
endif

silent! colorscheme habamax

highlight Normal ctermfg=252 ctermbg=235 guifg=#c0caf5 guibg=#1a1b26
highlight NormalNC ctermfg=250 ctermbg=235 guifg=#a9b1d6 guibg=#1a1b26
highlight EndOfBuffer ctermfg=235 ctermbg=235 guifg=#1a1b26 guibg=#1a1b26
highlight LineNr ctermfg=240 ctermbg=235 guifg=#3b4261 guibg=#1a1b26
highlight CursorLine ctermbg=236 guibg=#20233a
highlight CursorLineNr cterm=bold ctermfg=111 ctermbg=236 guifg=#7aa2f7 guibg=#20233a gui=bold
highlight VertSplit ctermfg=237 ctermbg=235 guifg=#292e42 guibg=#1a1b26
highlight Directory cterm=bold ctermfg=111 guifg=#7aa2f7 gui=bold
highlight NetrwDir cterm=bold ctermfg=111 guifg=#7aa2f7 gui=bold
highlight NetrwTreeBar ctermfg=240 guifg=#3b4261
highlight TabLine ctermfg=245 ctermbg=236 guifg=#737aa2 guibg=#20233a
highlight TabLineSel cterm=bold ctermfg=255 ctermbg=238 guifg=#c0caf5 guibg=#292e42 gui=bold
highlight TabLineFill ctermbg=235 guibg=#1a1b26
highlight SISUStatusMode cterm=bold ctermfg=16 ctermbg=111 guifg=#1a1b26 guibg=#7aa2f7 gui=bold
highlight SISUStatus ctermfg=252 ctermbg=237 guifg=#c0caf5 guibg=#292e42
highlight SISUStatusInfo ctermfg=117 ctermbg=237 guifg=#7dcfff guibg=#292e42
highlight SISUDashboardTitle cterm=bold ctermfg=111 guifg=#7aa2f7 gui=bold
highlight SISUDashboardSubtitle ctermfg=109 guifg=#7aa2f7
highlight SISUDashboardHint ctermfg=245 guifg=#737aa2
highlight SISUDashboardKey cterm=bold ctermfg=117 guifg=#7dcfff gui=bold

set statusline=%#SISUStatusMode#\ %{toupper(mode())}
set statusline+=%#SISUStatus#\ %f%m%r%h%w
set statusline+=%=
set statusline+=%#SISUStatusInfo#\ %{&filetype\ ==#\ ''\ ?\ 'text'\ :\ &filetype}\ %l:%c\ %p%%

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 30

nnoremap <silent> <leader>bg :let &background = &background ==# 'dark' ? 'light' : 'dark'<CR>
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
onoremap j gj
onoremap k gk
nnoremap Y y$
nnoremap <C-h> <C-w>h<C-w>_
nnoremap <C-j> <C-w>j<C-w>_
nnoremap <C-k> <C-w>k<C-w>_
nnoremap <C-l> <C-w>l<C-w>_
nnoremap <S-h> gT
nnoremap <S-l> gt
nnoremap <silent> <leader>/ :set invhlsearch<CR>
nnoremap <leader>= <C-w>=
nnoremap zl zL
nnoremap zh zH
nnoremap <F5> :Lexplore 30<CR>
nnoremap <leader>e :Lexplore 30<CR>
nnoremap <C-e> :Lexplore 30<CR>
nnoremap <leader>nt :Lexplore 30<CR>
nnoremap <leader>sh :SISUDashboard<CR>
xnoremap < <gv
xnoremap > >gv
xnoremap . :normal .<CR>

cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
nnoremap <leader>ew :edit %%<CR>
nnoremap <leader>es :split %%<CR>
nnoremap <leader>ev :vsplit %%<CR>
nnoremap <leader>et :tabedit %%<CR>
nnoremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
nnoremap <leader>q gwip
nnoremap <leader>jt :%!python3 -m json.tool<CR>:set filetype=json<CR>
nnoremap <leader>ff [I:let nr = input('Which one: ')<Bar>execute 'normal ' . nr . "[\t"<CR>

function! s:OpenLazyGit() abort
  if !executable('lazygit')
    echoerr 'SISUVim requires lazygit for <leader>gs. Install it and restart Vim.'
    return
  endif
  execute '!lazygit'
  redraw!
endfunction

command! SISULazyGit call <SID>OpenLazyGit()
nnoremap <silent> <leader>gs :SISULazyGit<CR>

function! s:OpenDashboard() abort
  enew
  setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
  setlocal nonumber norelativenumber nocursorline nowrap
  let l:padding = repeat(' ', max([2, (winwidth(0) - 46) / 2]))
  call setline(1, [
        \ '',
        \ l:padding . 'SISUVim',
        \ l:padding . 'A focused, keyboard-first Vim workspace',
        \ '',
        \ l:padding . '──────────────────────────────────────────────',
        \ '',
        \ l:padding . '<leader>e    Browse files',
        \ l:padding . '<leader>pf   Find files',
        \ l:padding . '<leader>fg   Search project text',
        \ l:padding . '<leader>gs   Open LazyGit',
        \ l:padding . '<leader>sh   Open this dashboard',
        \ '',
        \ l:padding . 'Open a file from the sidebar to begin.',
        \ ])
  silent! syntax clear SISUDashboardTitle SISUDashboardSubtitle SISUDashboardHint SISUDashboardKey
  syntax match SISUDashboardHint /^\s\{2\}.*/
  syntax match SISUDashboardSubtitle /^\s*A focused, keyboard-first Vim workspace\s*$/
  syntax match SISUDashboardTitle /^\s*SISUVim\s*$/
  syntax match SISUDashboardKey /<leader>\w\+/ containedin=ALL
  setlocal nomodifiable nomodified
  normal! gg
endfunction

function! s:OpenStartupWorkspace() abort
  if argc() != 0 || !has('ttyin') || get(g:, 'sisuvim_disable_startup_ui', 0)
    return
  endif
  call s:OpenDashboard()
  silent! Lexplore 30
  wincmd p
endfunction

command! SISUDashboard call <SID>OpenDashboard()

function! s:WrapRelativeMotion(key) abort
  return &wrap ? 'g' . a:key : a:key
endfunction
nnoremap <expr> $ <SID>WrapRelativeMotion('$')
nnoremap <expr> <End> <SID>WrapRelativeMotion('$')
nnoremap <expr> 0 <SID>WrapRelativeMotion('0')
nnoremap <expr> <Home> <SID>WrapRelativeMotion('0')
nnoremap <expr> ^ <SID>WrapRelativeMotion('^')
xnoremap <expr> $ <SID>WrapRelativeMotion('$')
xnoremap <expr> <End> <SID>WrapRelativeMotion('$')
xnoremap <expr> 0 <SID>WrapRelativeMotion('0')
xnoremap <expr> <Home> <SID>WrapRelativeMotion('0')
xnoremap <expr> ^ <SID>WrapRelativeMotion('^')
onoremap <expr> $ <SID>WrapRelativeMotion('$')
onoremap <expr> <End> <SID>WrapRelativeMotion('$')
onoremap <expr> 0 <SID>WrapRelativeMotion('0')
onoremap <expr> <Home> <SID>WrapRelativeMotion('0')
onoremap <expr> ^ <SID>WrapRelativeMotion('^')

command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang -nargs=* -complete=file Q q<bang> <args>
cabbrev Tabe tabe

for s:level in range(0, 9)
  execute 'nnoremap <leader>f' . s:level . ' :setlocal foldlevel=' . s:level . '<CR>'
endfor
unlet s:level

augroup sisuvim_indent
  autocmd!
  autocmd FileType haskell,javascript,javascriptreact,json,lua,ruby,typescript,typescriptreact,yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup sisuvim_startup
  autocmd!
  autocmd VimEnter * call <SID>OpenStartupWorkspace()
augroup END
