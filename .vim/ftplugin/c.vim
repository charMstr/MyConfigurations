" Vim filetype plugin file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2017 Sep 28

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Using line continuation here.
let s:cpo_save = &cpo
set cpo-=C

let b:undo_ftplugin = "setl fo< com< ofu< | if has('vms') | setl isk< | endif"

" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal fo-=t fo+=croql

" Set completion with CTRL-X CTRL-O to autoloaded function.
if exists('&ofu')
  setlocal ofu=ccomplete#Complete
endif

" Set 'comments' to format dashed lists in comments.
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s:/*,mb:**,ex:*/,f://

" In VMS C keywords contain '$' characters.
if has("vms")
  setlocal iskeyword+=$
endif

" When the matchit plugin is loaded, this makes the % command skip parens and
" braces in comments properly.
let b:match_words = '^\s*#\s*if\(\|def\|ndef\)\>:^\s*#\s*elif\>:^\s*#\s*else\>:^\s*#\s*endif\>'
let b:match_skip = 's:comment\|string\|character\|special'

" Win32 can filter files in the browse dialog
if (has("gui_win32") || has("gui_gtk")) && !exists("b:browsefilter")
  if &ft == "cpp"
    let b:browsefilter = "C++ Source Files (*.cpp *.c++)\t*.cpp;*.c++\n" .
	  \ "C Header Files (*.h)\t*.h\n" .
	  \ "C Source Files (*.c)\t*.c\n" .
	  \ "All Files (*.*)\t*.*\n"
  elseif &ft == "ch"
    let b:browsefilter = "Ch Source Files (*.ch *.chf)\t*.ch;*.chf\n" .
	  \ "C Header Files (*.h)\t*.h\n" .
	  \ "C Source Files (*.c)\t*.c\n" .
	  \ "All Files (*.*)\t*.*\n"
  else
    let b:browsefilter = "C Source Files (*.c)\t*.c\n" .
	  \ "C Header Files (*.h)\t*.h\n" .
	  \ "Ch Source Files (*.ch *.chf)\t*.ch;*.chf\n" .
	  \ "C++ Source Files (*.cpp *.c++)\t*.cpp;*.c++\n" .
	  \ "All Files (*.*)\t*.*\n"
  endif
endif

let &cpo = s:cpo_save
unlet s:cpo_save

"------------------------------------------------------------------------------
"- MY C FILETYPE----------------------------------------------------------- {{{

"PUT THE 42HEADING if at school
if ( $USER == "charmstr" )
	if !filereadable(expand('%'))
		exe "normal \<f1>"
	endif	
endif

"SET cindent
setlocal cindent foldmethod=indent foldnestmax=3 foldlevelstart=0

"SETING MY COMMENTS SPECIALLY
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s:/*,mb:**,ex:*/,f://

"CLEAN FILE FROM TRAILING SPACES AND TABS BEFORE WRITING
autocmd BufWritePre *.c %s/\(\s\|\t\)\+$//ge

"COMENT INLINE WITH ]c  adds "//"
nnoremap <buffer> <localleader>c I//<esc>
inoremap <buffer> <localleader>c <esc>I//<esc>

"UNCOMENT INLINE WITH ]u removes "//"
nnoremap <buffer> <localleader>u ^2x
inoremap <buffer> <localleader>u <esc>^2x

"COMENT MULTIPLE LINES WITH 'C'
nnoremap <buffer> <localleader>C o/*<cr><cr>/<esc>kA<space>
inoremap <buffer> <localleader>C <esc>o/*<cr><cr>/<esc>kA<space>

"ABBREVIATIONS FOR C
"IF
inoreabbrev <buffer> <silent> if if ()<Left><C-R>=Eatchar('\s')<cr>
"WHILE
inoreabbrev <buffer> <silent> while while ()<Left><C-R>=Eatchar('\s')<cr>
"FOR --> YOU CAN SHUT THE FUCK UP
"autocmd FileType c :inoreabbrev <buffer> <silent> for for ()<Left><C-R>=Eatchar('\s')<cr>
"MAIN
inoreabbrev <buffer> <silent> mainn int<tab>main(int argc __attribute__((unused)), char **argv __attribute__((unused)))<cr>{<cr>return (0);<cr>}<esc>kko<C-R>=Eatchar('\s')<cr>

"BRACES PAIRS
autocmd Filetype c :inoremap {<CR> {<CR>}<Esc>ko
"}
autocmd Filetype c :inoremap { {<CR>}<Esc>ko<C-R>=Eatchar('\s')<cr>
"}
autocmd Filetype c :inoremap {[ {
"}}
autocmd Filetype c :inoremap ( ()<Esc>i
")
autocmd Filetype c :inoremap (9 (
"))

"CORRECTIONS
inoreabbrev void* void *<C-R>=Eatchar('\s')<cr>
inoreabbrev char* char *<C-R>=Eatchar('\s')<cr>
inoreabbrev int* int *<C-R>=Eatchar('\s')<cr>
inoreabbrev t_list* t_list *<C-R>=Eatchar('\s')<cr>

"INCLUDE <.h>
inoreabbrev <buffer> #i #include <.h><esc>hhi<C-R>=Eatchar('\s')<cr>
"INCLUDE ".h"
inoreabbrev <buffer> #" #include ".h"<esc>hhi<C-R>=Eatchar('\s')<cr>
"DEFINE
inoreabbrev <buffer> #d #define
"RETURN
inoreabbrev <buffer> ret return<space>();<esc>hi<C-R>=Eatchar('\s')<cr>
"PRINTF
inoreabbrev <buffer> printf printf("\n");<esc>4hi<C-R>=Eatchar('\s')<cr>
"OPEN
inoreabbrev <buffer> openn if ((fd1 = open("", O_CREAT \| O_RDWR \| O_TRUNC, 0644)) == -1)<esc>10Bbe<C-R>=Eatchar('\s')<cr>
"READ
inoreabbrev <buffer> readd read(fd1, BUFFER_PTR, BUFFER_SIZE)<esc>5be<C-R>=Eatchar('\s')<cr>

"SEE PLUGIN SEGFAULT_HUNTER.VIM
nnoremap <buffer> <localleader>d :call InsertDebugPrintf()<cr>
nnoremap <buffer> <localleader>D :call RemoveDebugPrintf()<cr>

"CHEATPROOF
inoreabbrev <buffer> return NOPENOPENOPE
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- MY CPP FILETYPE--------------------------------------------------------- {{{

"CIN
inoreabbrev <buffer> cinn std::cin >> ;<esc>i<C-R>=Eatchar('\s')<cr>

"COUT
inoreabbrev <buffer> coutt std::cout << "" << std::endl;<esc>5ba<C-R>=Eatchar('\s')<cr>

" }}}
"------------------------------------------------------------------------------
