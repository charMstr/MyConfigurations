" Vim filetype plugin file
" Language:             YAML (YAML Ain't Markup Language)
" Previous Maintainer:  Nikolai Weibull <now@bitwi.se>
" Latest Revision:      2008-07-09

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< et< fo<"

setlocal comments=:# commentstring=#\ %s expandtab
setlocal formatoptions-=t formatoptions+=croql

let &cpo = s:cpo_save
unlet s:cpo_save

"------------------------------------------------------------------------------
"- MY YAML FILETYPE-------------------------------------------------------- {{{

"COMMENT IN LINE
"SET TWO NICE TABS WHEN I PRESS ENTER
setlocal ts=2 sts=2 sw=2 expandtab

"COMENT INLINE WITH ]c  adds "#"
nnoremap <buffer> <localleader>c I#<esc>

"UNCOMENT INLINE WITH ]u removes "#"
nnoremap <buffer> <localleader>u ^x
" }}}
"------------------------------------------------------------------------------
