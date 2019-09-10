"WELCOME USELESS MESSAGE, STAY IN TH EMESSAGE HISTORY
echo ">^.^<"
"silent echo ">^.^<"

"KEEPS THE DEFAULTS.VIM SETTINGS
" unlet! skip_defaults_vim
" source $VIMRUNTIME/defaults.vim

"------------------------------------------------------------------------------
"- VIMSCRIPT FILE SETTINGS ------------------------------------------------ {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker foldlevelstart=0
augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- GENERAL/DISPLAY -------------------------------------------------------- {{{

"LEADER KEY
let mapleader = 'fj'
let maplocalleader = ']'

syntax enable
set mouse=a
set autoindent
set smartindent
set ruler
set shiftwidth=4

"HIGHLIGHT SEARCHES
set hlsearch incsearch

"MAKES SEARCHES WITH REGEX ACT MORE NORMALLY
"SEARCHES/REGEX --> help pattern-overview
set magic
"STARTS A SEARCH WITH "VERY MAGIC" MODE SET UP
nnoremap / :/\v

"HILIGHT MATCHING PARENTHESIS
hi MatchParen ctermbg=green ctermfg=black

"COLOR FOR COMMENTS
highlight comment cterm=italic ctermbg=lightcyan ctermfg=0

"NUMBERS-WISE / RELATIVENUMBER ON-OFF ...
set number
set numberwidth=4
noremap \ :set relativenumber!<CR>

"APPLIES TO > AND >, ROUND THE INDENT TO A MULTIPLY OF SHIFTWIDTH
set shiftround

"MAX 80 CHAR PER LINE
highlight ColorColumn ctermbg=lightred ctermfg=darkred
set colorcolumn=80

"SET ERRORBELLS OFF , ESPECIALLY FLASHING SCREEN
set noerrorbells visualbell t_vb=

"STATUS LINE
set statusline=\ 							"space
set statusline+=%.25F						"path to file
set statusline+=%=							"align to the right of the window
set statusline+=Line:\ %l\ /\ %L\ \ \ 		"Line: number / total 

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- OPERATOR-PENDING ------------------------------------------------------- {{{
"WORD
onoremap w iw

"UNTIL END / START OF LINE
onoremap L :<c-u>normal! vg_<cr>
onoremap H :<c-u>normal! v0<cr>

"INSIDE '('
onoremap ( :<c-u>normal! vi(<cr>
"NEXT '('
onoremap in( :<c-u>exe "normal! /(\\{1}\r:nohlsearch\rvi("<cr>
onoremap on( :<c-u>exe "normal! /(\\{1}\r:nohlsearch\rhv^"<cr>
"LAST '('
onoremap il( :<c-u>exe "normal! ?(\\{1}\r:nohlsearch\rvi("<cr>
onoremap ol( :<c-u>exe "normal! ?(\\{1}\r:nohlsearch\rhv^"<cr>

"INSIDE '"'
onoremap " :<c-u>normal! vi"<cr>
"NEXT '"'
onoremap in" :<c-u>exe "normal! /\"\\{1}\r:nohlsearch\rvi\""<cr>
onoremap on" :<c-u>exe "normal! /\"\\{1}\r:nohlsearch\rhv^"<cr>
"LAST '"'
onoremap il" :<c-u>exe "normal! 2?\"\\{1}\r:nohlsearch\rlvi\""<cr>
onoremap ol" :<c-u>exe "normal! 2?\"\\{1}\r:nohlsearch\rhv^"<cr>

"INSIDE '{'
onoremap { :<c-u>normal! vi{h<cr>
"NEXT '{'
onoremap in{ :<c-u>exe "normal! /{\\{1}\r:nohlsearch\rvi{h"<cr>
onoremap on{ :<c-u>exe "normal! /{\\{1}\r:nohlsearch\rkvg_"<cr>
"LAST '{'
onoremap il{ :<c-u>exe "normal! ?}\\{1}\r:nohlsearch\rvi{h"<cr>
onoremap ol{ :<c-u>exe "normal! ?{\\{1}\r:nohlsearch\rkvg_"<cr>

"INSIDE '['
onoremap [ :<c-u>normal! vi[<cr>
"NEXT '['
onoremap in[ :<c-u>exe "normal! /[\\{1}\r:nohlsearch\rvi["<cr>
onoremap on[ :<c-u>exe "normal! /[\\{1}\r:nohlsearch\rhv^"<cr>
"LAST '['
onoremap il[ :<c-u>exe "normal! ?]\\{1}\r:nohlsearch\rvi["<cr>
onoremap ol[ :<c-u>exe "normal! ?[\\{1}\r:nohlsearch\rhv^"<cr>

"RETURN
onoremap inr :<c-u>exe "normal! /return (\\{1}\r:nohlsearch\rf(vi("<cr>
onoremap ilr :<c-u>exe "normal! ?return (\\{1}\r:nohlsearch\rf(vi("<cr>

"NEXT E-MAIL ADDRESS
noremap in@ :<c-u>exe "normal! /@\\{1}\r:nohlsearch\rhviw"<cr>

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- MAPPINGS/ABBREVIATION -------------------------------------------------- {{{

"REMAP THE ESCAPE KEY
noremap dk <esc>
noremap! dk <esc>

"EDITING ('e') .VIMRC FILE ('v') AT THE TOP OF THE WINDOW (30 LINES)
"SOURCING ('s') .VIMRC FILE ('v')
nnoremap <leader>ev :rightbelow vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

"OPENING LAST('l') BUFFER
nnoremap <leader>l :execute "vsplit " . bufname("#")<cr>

"MOVE A LINE DOWNWARD / UPWARD
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP "be carefull with the upper line!

"MOVE THE CURSOR / +restrictions on arrows
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
"MOVE BETWEEN LONG WRAPPING LINES
noremap j gj
noremap k gk

"MAKES WORD A STRING
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
inoremap <leader>" <esc>viw<esc>a"<esc>bi"<esc>A
vnoremap " <esc>a"<esc>`<i"<esc>`>ll

"UPPER CASE A WORD IN INSERT MODE / NORMAL MODE
inoremap <leader>u <esc>viwUea
inoremap <leader>U <esc>VUA
nnoremap <leader>u viwU
nnoremap <leader>U VU

"FINDS TRAILING WHITESPACES/TABS ('w') --> SUPPRESSES ONE, HIGHLIGHTS THE REST
nnoremap <leader>w :match Error /\v( \|\t)+$/<cr>
nnoremap <silent> <leader>W :call clearmatches()<cr> | :noh

"INSERT A ';' AT THE END OF THE LINE. nb: IT COULD BE TRIGGERED ON AN EVENT...
inoremap <leader>; <esc>mqA;<esc>`qa
nnoremap <leader>; <esc>mqA;<esc>`q

"FUNCTIONS FOR ABBREVIATIONS
func! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc
"exemple
"iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<cr>

"ABBREVIATIONS (INSERT MODE ONLY TODAY)
iabbr cahr char
iabbr whiel while
iabbr fi if
iabbr srt str
iabbr @@ charmstr@student.42.fr

"CONTROL OF TABULATIONS
nnoremap <leader>tc :tabc<cr>
nnoremap <leader>tj :tabp<cr>
nnoremap <leader>tk :tabn<cr>
"CLOSE ALL EXCEPT FOR THE CURRETN ONE
nnoremap <leader>to :tabo<cr>

"nnoremap
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- AUTO-COMMANDS ---------------------------------------------------------- {{{

"CREAT A NEW FILE NO MATTER WHAT
"autocmd BufNewFile * :write

"------------------------------------------------------------------------------
"- .H FILETYPE------------------------------------------------------------- {{{

"CREAT A .H FILE AUTOMATICALLY
augroup filetype_h
	autocmd!
	"CLEAN FILE FROM TRAILING SPACES AND TABS BEFORE WRITING
	autocmd BufWritePre *.h %s/\(\s\|\t\)\+$//ge

	"INSERT THE 42 HEADER AT THE TOP OF THE FILE
	"INSERT THE ROOTNAME OF THE FILE '%:R' + '_' +
	"THE EXTENSION OF THE FILE 'H' ==> ALL IN UPPER CASE
	autocmd BufNewfile *.h :exe "normal \<f1>dd" | exe "normal! i" . toupper(join([expand('%:t:r'),'_',expand('%:e')], "")) | exe "normal! yyPI#ifndef \<esc>jI# define \<esc>3o\<esc>o#endif\<esc>kki"
	
	"ABBREVIATIONS
	"INCLUDES <
	autocmd BufNewFile,BufRead *.h :ia <buffer> #i # include <.h><esc>hhi<C-R>=Eatchar('\s')<cr>
	"INCLUDES "
	autocmd BufNewFile,BufRead *.h :ia <buffer> #" # include ".h"<esc>hhi<C-R>=Eatchar('\s')<cr>
	"DEFINE
	autocmd BufNewFile,BufRead *.h :ia <buffer> #d # define
	"IFNDEF
    	autocmd BufNewFile,BufRead *.h :ia <buffer> ifndef # ifndef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>
	"IFDEF
    	autocmd BufNewFile,BufRead *.h :ia <buffer> ifdef # ifdef <esc>o# endif<esc>k3o<esc>3kA<C-R>=Eatchar('\s')<cr>

augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- .ELEC FILETYPE---------------------------------------------------------- {{{

augroup filetype_elec
	autocmd!
	"HAVE THE CURRENT LINE HIGHLIGHTED
	autocmd BufNewFile,BufRead *.elec setlocal cursorline cc=0
augroup END

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- MARKDOWN/TXT FILETYPE--------------------------------------------------- {{{

augroup filetype_txt
	autocmd!
	autocmd BufRead *.txt onoremap <buffer> ih1 :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
	autocmd BufRead *.txt onoremap <buffer> ih2 :<c-u>execute "normal! ?^--\\+$\r:nohlsearch\rkvg_"<cr>
augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- HTML FILETYPE----------------------------------------------------------- {{{

"REARANGES A .HTML FILE BEFORE WRITING
autocmd BufWritePre *.html :normal gg=G

"PAIRING RED AND NEWFILE AUTOCOMMANDS FOR A .HTML
autocmd BufNewFile,BufRead *.html setlocal nowrap

"finds the matching tags and does
augroup filetype_html
	autocmd!
	autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- .SH FILETYPE------------------------------------------------------------ {{{

augroup filetype_sh
	autocmd!

	"HAVE THE CURRENT LINE HIGHLIGHTED
	autocmd BufNewFile,BufRead *.sh setlocal cursorline cc=0

	"INSERT THE SHEBANG AT TOP 
	autocmd BufNewFile *.sh :exe "normal i#!/bin/sh" | :exe "normal 2o"
	
	"DO A CHMOD 755 ON FILE AFTER SAVING
	autocmd BufWritePost *.sh :silent !{chmod 755 %}

	"RESET THE INDENT FOR SHELL SCRIPTS
	autocmd BufNewFile,BufRead *.sh  setlocal noautoindent
	autocmd BufNewFile,BufRead *.sh  setlocal nosmartindent
	
	"COMENT INLINE WITH ]c  adds "#"
	autocmd FileType sh nnoremap <buffer> <localleader>c I#<esc>

	"UNCOMENT INLINE WITH ]u removes "#"
	autocmd FileType sh nnoremap <buffer> <localleader>u ^x

	"ABBREVIATIONS FOR SHELL
	"WHILE 
	autocmd FileType sh :iabbrev <buffer> <silent> while while [  ]<esc>odo<esc>o<tab><esc>odone<esc>kkkWlli<C-R>=Eatchar('\s')<cr>
	"FOR
	autocmd FileType sh :iabbrev <buffer> <silent> for for $ in<esc>odo<esc>o<tab><esc>odone<esc>kkkWli<C-R>=Eatchar('\s')<cr>
	"IF 
	autocmd FileType sh :iabbrev <buffer> <silent> if if [  ]<esc>othen<esc>o<tab><esc>o#elif [  ]; then<esc>o#else<esc>ofi<esc>kkkkkWlli<C-R>=Eatchar('\s')<cr>
	"ECHO
	autocmd Filetype sh :iabbrev <buffer> <silent> echo echo ""<left><C-R>=Eatchar('\s')<cr>
	"CASE
	autocmd Filetype sh :iabbrev <buffer> <silent> case case $ in<esc>o<tab>*)<tab><tab><esc>o<tab><tab>;;<esc>oesac<esc>3kWa<C-R>=Eatchar('\s')<cr>

augroup END

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- C FILETYPE-------------------------------------------------------------- {{{

augroup filetype_c
	autocmd!
	"PUT THE 42HEADING
	autocmd BufNewFile *.c :exe "normal \<f1>"

	"SET cindent
	autocmd BufNewFile,BufRead *.c setlocal cindent foldmethod=indent foldnestmax=3 foldlevelstart=0

	"CLEAN FILE FROM TRAILING SPACES AND TABS BEFORE WRITING
	autocmd BufWritePre *.c %s/\(\s\|\t\)\+$//ge

	"COMENT INLINE WITH ]c  adds "//"
	autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>

	"UNCOMENT INLINE WITH ]u removes "//"
	autocmd FileType c nnoremap <buffer> <localleader>u ^2x

	"COMENT MULTIPLE LINES WITH 'C'
	autocmd FileType c nnoremap <buffer> <localleader>C o/*<cr>**<cr>*/<esc>
	"o<esc>kkA<space>

	"ABBREVIATIONS FOR C
	autocmd FileType c :iabbrev <buffer> <silent> if if ()<Left><C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> <silent> while while ()<Left><C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> <silent> for for ()<Left><C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> <silent> main int<tab>main(int argc, char *argv[])<cr>{<cr>return (0);<cr>}<esc>kko<C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> <silent> { {<cr>}<esc>ko<C-R>=Eatchar('\s')<cr>
	"}
	autocmd FileType c :iabbrev <buffer> <silent> ( ()<esc>i<C-R>=Eatchar('\s')<cr>
	")
	autocmd FileType c :iabbrev <buffer> #i #include <.h><esc>hhi<C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> #" #include ".h"<esc>hhi<C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> #d #define
	autocmd FileType c :iabbrev <buffer> ret return<space>();<esc>hi<C-R>=Eatchar('\s')<cr>
	autocmd FileType c :iabbrev <buffer> printf printf("");<esc>hhi<C-R>=Eatchar('\s')<cr>

	"CHEATPROOF
	autocmd FileType c :iabbrev <buffer> return NOPENOPENOPE
augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- JAVASCRIPT FILETYPE----------------------------------------------------- {{{

"COMMENT IN LINE
augroup filetype_js
	autocmd!
	autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- PYTHON FILETYPE--------------------------------------------------------- {{{

"COMMENT INLINE
augroup filetype_py
	autocmd!
	autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
augroup END
" }}}
"------------------------------------------------------------------------------

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- IMPORTANT DETAILS--------------------------------------------------------- {{{

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- FUNCTIONS -------------------------------------------------------------- {{{

"INSERTING DATE AND TIME
nnoremap <leader>D :call DateAndTime()<cr>
inoremap <leader>D :call DateAndTime()<cr>
function! DateAndTime()
	:put =expand(strftime('%a %d/%m/%Y at %T'))
endfunction

"IF TEXTWIDTH IS MORE THAN 80
function! TextWidthIsTooWide()
	if &l:textwidth ># 80
		return 1
	endif
endfunction

" }}}
"------------------------------------------------------------------------------

