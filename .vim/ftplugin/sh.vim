" Vim filetype plugin file
" Language:	sh
" Maintainer:	Dan Sharp <dwsharp at users dot sourceforge dot net>
" Last Changed: 20 Jan 2009
" URL:		http://dwsharp.users.sourceforge.net/vim/ftplugin

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

" Make sure the continuation lines below do not cause problems in
" compatibility mode.
let s:save_cpo = &cpo
set cpo-=C

setlocal commentstring=#%s

" Shell:  thanks to Johannes Zellner
if exists("loaded_matchit")
    let s:sol = '\%(;\s*\|^\s*\)\@<='  " start of line
    let b:match_words =
    \ s:sol.'if\>:' . s:sol.'elif\>:' . s:sol.'else\>:' . s:sol. 'fi\>,' .
    \ s:sol.'\%(for\|while\)\>:' . s:sol. 'done\>,' .
    \ s:sol.'case\>:' . s:sol. 'esac\>'
endif

" Change the :browse e filter to primarily show shell-related files.
if has("gui_win32")
    let  b:browsefilter="Bourne Shell Scripts (*.sh)\t*.sh\n" .
		\	"Korn Shell Scripts (*.ksh)\t*.ksh\n" .
		\	"Bash Shell Scripts (*.bash)\t*.bash\n" .
		\	"All Files (*.*)\t*.*\n"
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "setlocal cms< | unlet! b:browsefilter b:match_words"

" Restore the saved compatibility options.
let &cpo = s:save_cpo
unlet s:save_cpo

"------------------------------------------------------------------------------
"- MY .SH FILETYPE--------------------------------------------------------- {{{

"HAVE THE CURRENT LINE HIGHLIGHTED
autocmd BufNewFile,BufRead *.sh setlocal cursorline cc=0

"THIS AUTOCOMMAND IS ESSENTIAL BECAUSE IT CREATES THE FILE FOR THE COLOR PANEL IN THE CURRENT DIR
"NOTE: IMPOSSIBLE TO USE A RELATIVE PATH WITH CAT INSIDE THE TERMINAL EMULATION
autocmd BufNewFile,BufRead *.sh silent! !cp ~/Myconfigurations/color_panel_cat_me color_panel_cat_me
autocmd VimLeave *.sh silent! !rm color_panel_cat_me
"CAT THE COLOR_PANEL ON THE FAR RIGHT/VERT SPLIT
nnoremap <buffer> <leader>col :call Display_panel_colors()<cr>

"INSERT THE SHEBANG AT TOP ONLY IF ITS A NEW FILE
if !filereadable(expand('%'))
	exe "normal i#!/bin/sh" | :exe "normal 2o"
endif	

"DO A CHMOD 755 ON FILE AFTER SAVING
autocmd BufWritePost *.sh :silent !{chmod 755 %}
	
"COMENT INLINE WITH ]c  adds "#"
nnoremap <buffer> <localleader>c I#<esc>

"UNCOMENT INLINE WITH ]u removes "#"
autocmd FileType sh nnoremap <buffer> <localleader>u ^x

"WE JUST WANT TO KEEP THE INDENTATION FROM THE PREVIOUS LINE FROM AUTOINDENT
set nosmartindent

"ABBREVIATIONS FOR SHELL
"WHILE 
iabbrev <buffer> <silent> while while [  ]<esc>odo<esc>o<tab><esc>o<BS>done<esc>kkkWlli<C-R>=Eatchar('\s')<cr>
"FOR
iabbrev <buffer> <silent> for for $ in #VARIABLE<esc>odo<esc>o<tab><esc>o<BS>done<esc>kkkWli<C-R>=Eatchar('\s')<cr>
"IF 
iabbrev <buffer> <silent> if if [  ]<esc>othen<esc>o<tab><esc>o#elif [  ]; then<esc>o#else<esc>o<BS>fi<esc>kkkkkWlli<C-R>=Eatchar('\s')<cr>
"ECHO
iabbrev <buffer> <silent> echo echo ""<left><C-R>=Eatchar('\s')<cr>
"CASE
iabbrev <buffer> <silent> case case $ in #VARIABLE<esc>o<tab>*)#LAST CASE<esc>o<tab>;;<esc>o<BS><BS>esac<esc>3kWa<C-R>=Eatchar('\s')<cr>

"BUILD A VARIABLE  <leader>v  -->  ${cursor}
inoremap <buffer> <leader>v ${}<esc>i
" }}}
"------------------------------------------------------------------------------
