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

"PUT THE 42HEADING IF AT SCHOOL. ONLY IF THE FILE HAS NOT BEEN CREATED YET
if !filereadable(expand('%'))
	"IF WE HAVE A .H OR .HPP FILE
	if (expand('%:e') == "h") || (expand('%:e') == "hpp")
		exe "normal \<f1>" | exe "normal! i" . toupper(substitute(expand('%:t'), "\\.", "_", "g")) | exe "normal! yyPI#ifndef \<esc>jI# define \<esc>3o\<esc>o#endif\<esc>kki"
	else
		"IF WE HAVE A .C OR .CPP FILE
		exe "normal \<f1>"
	endif	
endif

"ONLY FOR H_FILES
if expand('%:e') == "h" || expand('%:e') == "hpp"
	"ABBREVIATIONS
	"INCLUDES <
	inoreabbrev <buffer> #i # include <><esc>i<C-R>=Eatchar('\s')<cr>
	"INCLUDES "
	inoreabbrev <buffer> #" # include ""<esc>i<C-R>=Eatchar('\s')<cr>
	"DEFINE
	inoreabbrev <buffer> #d # define
	"IFNDEF
	inoreabbrev <buffer> ifndef # ifndef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>
	"IFDEF
	inoreabbrev <buffer> ifdef # ifdef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>
	"CLASS
	inoreabbrev <buffer> <silent> typedefs typedef struct<tab>s_<cr>{<cr>}<tab><tab><tab><tab>t_;<esc>2kA<C-R>=Eatchar('\s')<cr>
	"TYPEDEF: typedefe -> typedef enum ... etc.
	inoreabbrev <buffer> <silent> typedefe typedef enum<tab>e_<cr>{<cr>//<tab>coma, separated, without, trailing, semicolumn<cr>}<tab><tab><tab><tab>t_;<esc>3kA<C-R>=Eatchar('\s')<cr>
else
	"INCLUDE <.h>
	inoreabbrev <buffer> #i #include <><esc>i<C-R>=Eatchar('\s')<cr>
	"INCLUDE ".h"
	inoreabbrev <buffer> #" #include ""<esc>i<C-R>=Eatchar('\s')<cr>
	"DEFINE
	inoreabbrev <buffer> #d #define
	"RETURN
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
inoremap <buffer> <silent> mainn int<tab>main(int argc __attribute__((unused)), char **argv __attribute__((unused)))<cr>{<cr>return (0);<cr>}<esc>kko<C-R>=Eatchar('\s')<cr>

"BRACES PAIRS
"{ TWICE
inoremap {{ {<CR>}<Esc>ko<C-R>=Eatchar('\s')<cr>
"IN CASE WE MISS THE SECOND UPERCASE
inoremap {[ {<CR>}<Esc>ko<C-R>=Eatchar('\s')<cr>
"( twice
inoremap (( ()<Esc>i
"IN CASE WE MISS THE SECOND UPERCASE
inoremap (9 ()<Esc>i

"CORRECTIONS
inoreabbrev void* void *<C-R>=Eatchar('\s')<cr>
inoreabbrev char* char *<C-R>=Eatchar('\s')<cr>
inoreabbrev int* int *<C-R>=Eatchar('\s')<cr>
inoreabbrev t_list* t_list *<C-R>=Eatchar('\s')<cr>

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

"LEARN THE HARD WAY
"inoreabbrev <buffer> return NOPENOPENOPE
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- MY CPP FILETYPE--------------------------------------------------------- {{{

"ABREVIATIONS FOR CPP
"CIN
inoremap <buffer> cinn std::cin >> ;<esc>i<C-R>=Eatchar('\s')<cr>

"COUT
inoremap <buffer> coutt std::cout << "" << std::endl;<esc>5ba<C-R>=Eatchar('\s')<cr>

"ALIASING THE COMMAND ClassNewCpp: just type: ClassNewCpp nameOfClass
command! -nargs=1 ClassNewCpp call ft#classNewCpp#ClassNewCpp(<f-args>) 

" }}}
"------------------------------------------------------------------------------
