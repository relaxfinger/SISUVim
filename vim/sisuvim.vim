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
syntax enable

if has('clipboard')
  set clipboard+=unnamedplus
endif

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
nnoremap <F5> :Explore<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <C-e> :Explore<CR>
nnoremap <leader>nt :Explore<CR>
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
