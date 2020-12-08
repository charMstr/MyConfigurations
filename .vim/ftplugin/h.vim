"this line maked sure the default plugin is not added if existing.
let b:did_ftplugin = 1

"IF THE FILE IS NEW: WE WILL SET THE 42 HEADER
if !filereadable(expand('%'))
	exe "normal \<f1>" | exe "normal! i" . toupper(substitute(expand('%:t'), "\\.", "_", "g")) | exe "normal! yyPI#ifndef \<esc>jI# define \<esc>3o\<esc>o#endif\<esc>kki"
endif

"CLEAN FILE FROM TRAILING SPACES AND TABS BEFORE WRITING
autocmd BufWritePre *.hpp %s/\(\s\|\t\)\+$//ge

"SET cindent
setlocal cindent foldmethod=indent foldnestmax=3 foldlevelstart=0

"ABBREVIATIONS
"INCLUDES <
inoreabbrev <buffer> #i # include <.h><esc>hhi<C-R>=Eatchar('\s')<cr>
"INCLUDES "
inoreabbrev <buffer> #" # include ".h"<esc>hhi<C-R>=Eatchar('\s')<cr>
"DEFINE
inoreabbrev <buffer> #d # define
"IFNDEF
inoreabbrev <buffer> ifndef # ifndef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>
"IFDEF
inoreabbrev <buffer> ifdef # ifdef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>
"CLASS
inoreabbrev <buffer> <silent> class class<cr>{<cr>public:<cr>private:<cr>};<esc>4kA<space><C-R>=Eatchar('\s')<cr>
"TYPEDEF: typedefs -> typedef struct ... etc.
inoreabbrev <buffer> <silent> typedefs typedef struct<tab>s_<cr>{<cr>}<tab><tab><tab><tab>t_;<esc>2kA<C-R>=Eatchar('\s')<cr>
"TYPEDEF: typedefe -> typedef enum ... etc.
inoreabbrev <buffer> <silent> typedefe typedef enum<tab>e_<cr>{<cr>//<tab>coma, separated, without, trailing, semicolumn<cr>}<tab><tab><tab><tab>t_;<esc>3kA<C-R>=Eatchar('\s')<cr>

" Behaves just like C regarding the syntax
runtime! syntax/c.vim
