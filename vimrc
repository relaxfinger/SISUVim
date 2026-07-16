if v:version < 900
  echoerr 'SISUVim requires Vim 9.0 or newer.'
  finish
endif

let s:sisuvim_root = fnamemodify(resolve(expand('<sfile>:p')), ':h')
execute 'source ' . fnameescape(s:sisuvim_root . '/vim/sisuvim.vim')
