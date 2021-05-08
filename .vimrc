"WELCOME USELESS MESSAGE, STAY IN TH EMESSAGE HISTORY
silent echo ">^.^<"
"silen echo ">^.^<"

"note: vundle needs to be a the start.
"------------------------------------------------------------------------------
"- VUNDLE PLUGINS MANAGER ------------------------------------------------- {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"" plugin from http://vim-scripts.org/vim/scripts.html
"" Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Install L9 and avoid a Naming conflict if you've already installed a
"" different version somewhere else.
"" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" NOTE: see the YCM section in this .vimrc file for completion mapings.
" }}}
"------------------------------------------------------------------------------

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

"MAKE SURE WE CAN USE THE DEL KEY IN ALL OF THOSE SITUATIONS IN INSERT MODE
set backspace=indent,eol,start

syntax enable
set mouse=a
set ruler

"MAKE SURE THE COLORSCHEME IS DEFAULT (colorscheme)
colorscheme default

"COLOR and highlighting FOR COMMENTS (comments color)
hi Comment term=bold cterm=italic ctermfg=lightcyan ctermbg=0 guifg=#80a0ff

"toggle the color and highlighting for comments with the '|' (pipe) key
nnoremap \| :call CommentHighlightToggle()<cr>
let g:commentHighlightToggle = 0
function! CommentHighlightToggle()
	if g:commentHighlightToggle
        let g:commentHighlightToggle = 0
		hi Comment term=bold cterm=italic ctermfg=lightcyan ctermbg=0 guifg=#80a0ff
    else
        let g:commentHighlightToggle = 1
		hi Comment term=bold cterm=italic ctermfg=236 ctermbg=233 guifg=#80a0ff
	endif
endfunction


"MAKE SURE THE FILETYPE DETECTION IS ONE, AND THE PLUGINS ARE LOADED
filetype on
filetype plugin on

"RESPECTING THE NORME AT 42:
"SET BY DEFAULT. IT PREVENTS INSERTING SPACES IN PLACE OF TABS
set softtabstop=0 noexpandtab
" SHOW EXISTING TAB WITH 4 SPACES WIDTH
set tabstop=4
" WHEN INDENTING WITH '>', USE 4 SPACES WIDTH
set shiftwidth=4

"NOTE: WHEN USING smartindent, autoindent SHOULD BE ON
"NOTE2: WHEN cindent IS ON IT WILL OVERRULE SMARTINDENT
set autoindent
set smartindent

"HIGHLIGHT SEARCHES
set hlsearch incsearch

"MAKES SEARCHES WITH REGEX ACT MORE NORMALLY
"SEARCHES/REGEX --> help pattern-overview
set magic
"STARTS A SEARCH WITH "VERY MAGIC" MODE SET UP
nnoremap / :/\v
"VERY USEFULL TO MOVE AROUND TO THE NEXT WORD THATS UNDER THE CURSOR
nnoremap * * :nohlsearch<cr>

"HILIGHT MATCHING PARENTHESIS
hi MatchParen ctermbg=green ctermfg=black

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


"INSERTING DATE AND TIME
nnoremap <leader>D k:call DateAndTime()<cr>
inoremap <leader>D <esc>k:call DateAndTime()<cr>

"TODO:
inoremap TODO <esc>:call ToDoFunc()<cr>

"SPOT CURRENT LINE
nnoremap <leader><space> :call Flash()<cr>

"STATUS LINE
set statusline=\ 							"space
set statusline+=%.25F						"path to file
set statusline+=%=							"align to the right of the window
set statusline+=Line:\ %l\ /\ %L\ \ \ 		"Line: number / total 

" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- YOU COMPLETE ME - YCM -------------------------------------------------- {{{

"AUTOCOMPLETION:
"FIRST REMOVE THE TERMINAL MAPIN FOR CTRL + J = <CR>
let g:BASH_Ctrl_j = 'off'
"MOVING DOWN IN THE AUTO-COMPLETION: CTRL + J
let g:ycm_key_list_select_completion = ['<C-J>', '<Down>']
"MOVING UP IN THE AUTO-COMPLETION: CTRL + K
let g:ycm_key_list_previous_completion = ['<C-K>', '<Up>']
"TRIGGER AUTOCOMPLETION WHEN IN INSERT MODE (default but just for the record.
let g:ycm_key_invoke_completion = '<C-Space>'

"POPUP WINDOW
"deactivate the time delay (empty string instead of Cursorhold)
let g:ycm_auto_hover = ""
"TRIGER IT WITH <SPACE>
nmap <space> <plug>(YCMHover)

"GET DOCUMENTATION
nnoremap <leader>gd :YcmCompleter GetDoc<cr>
"GOTO INCLUDE => DO IT ON THE SAME LINE AS IN INCLUDE COMMANDE
nnoremap <leader>in :YcmCompleter GoToInclude<cr>
"GOTO DECLARATION
nnoremap <leader>dc :YcmCompleter GoToDeclaration<cr>
"GOTO DEFINITION
nnoremap <leader>df :YcmCompleter GoToDefinition<cr>
"FIX IT
nnoremap <leader>f :YcmCompleter FixIt<cr>

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

"INSIDE '<'
onoremap < :<c-u>normal! vi<<cr>
"NEXT '<'
onoremap in< :<c-u>exe "normal! /<\\{1}\r:nohlsearch\rvi<"<cr>
onoremap on< :<c-u>exe "normal! /<\\{1}\r:nohlsearch\rhv^"<cr>
"LAST '<'
onoremap il< :<c-u>exe "normal! ?<\\{1}\r:nohlsearch\rvi<"<cr>
onoremap ol< :<c-u>exe "normal! ?<\\{1}\r:nohlsearch\rhv^"<cr>

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

"REMAP DD BECAUSE IT IS SLOW OTHERWISE TO DELETE CURRENT LINE
nnoremap dl dd

"EDITING ('e') .VIMRC FILE ('v') AT THE TOP OF THE WINDOW (30 LINES)
"SOURCING ('s') .VIMRC FILE ('v')
nnoremap <leader>ev :rightbelow vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

"OPENING LAST('l') BUFFER
nnoremap <leader>l :<C-U>execute "vsplit " . bufname("#")<cr>

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
inoremap <leader>;; <esc>mq$x<esc>`qa
nnoremap <leader>; <esc>mqA;<esc>`q
nnoremap <leader>;; <esc>mq$x<esc>`q

"FUNCTIONS FOR ABBREVIATIONS
func! Eatchar(pat)
let c = nr2char(getchar(0))
return (c =~ a:pat) ? '' : c
endfunc
"exemple
"iabbr <silent> if if ()<Left><C-R>=Eatchar('\s')<cr>

"ABBREVIATIONS (INSERT MODE ONLY TODAY)
inoreabbr cahr char
inoreabbr whiel while
inoreabbr fi if
inoreabbr srt str
inoreabbr @@ charmstr@student.42.fr

"PREPARE THE STRING WITH THE TERMCAP COLOR
inoremap <buffer> <leader>fg  \033[38;5;\033[m<esc>6ha
inoremap <buffer> <leader>bg  \033[48;5;\033[m<esc>6ha

"CONTROL OF TABULATIONS
"Close
nnoremap <leader>tc :tabc<cr>
"Next
nnoremap <leader>tj :tabp<cr>
"Previous
nnoremap <leader>tk :tabn<cr>
"CLOSE ALL EXCEPT FOR THE CURRETN ONE
nnoremap <leader>to :tabo<cr>

"nnoremap
" }}}
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"- AUTO-COMMANDS --------------------------------------------------------- {{{
" NOTE: these should be remove and placed inside the ftdetected/ and ftplugin/
" folders

"CREAT A NEW FILE NO MATTER WHAT
"autocmd BufNewFile * :write
"
"------------------------------------------------------------------------------
"- HTML FILETYPE----------------------------------------------------------- {{{

augroup filetype_html
autocmd!
"REARANGES A .HTML FILE (INDENTATION FIXED!)
autocmd BufRead,BufWritePre *.html :normal gg=G

"PAIRING READ AND NEWFILE AUTOCOMMANDS FOR A .HTML
autocmd BufNewFile,BufRead *.html setlocal nowrap

"FINDS THE MATCHING TAGS AND DOES A FOLDING ON THE PARAGRAPH
autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
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
"- FUNCTIONS -------------------------------------------------------------- {{{

"FUNCTION TO INSERT IN PLACE THE DATE AND TIME
function! DateAndTime()
:put =expand(strftime('%a %d/%m/%Y at %T'))
endfunction

"IF TEXTWIDTH IS MORE THAN 80
function! TextWidthIsTooWide()
if &l:textwidth ># 80
		return 1
	endif
endfunction

"THIS FUNCTION WILL FLASH THE CURRENT LINE FOR A TENTH OF A SEC
function! Flash()
	set cursorline
	redraw
	sleep 100m
	set nocursorline
endfunction


"THIS CUSTOMED FUNCTION ORIGINALLY COMES FROM THE CURSORHOLD-EXAMPLE IN VIM HELP
"IT WILL OPEN A PREVIEW WINDOW ON A TAGGED NAME AND HIGHLIGHT THAT WORD
"USAGE: HIT SPACE WHILE OVERING A NAME
"IF WE CALL THE FUNCTION ON THE EXACT SAME NAME IT WILL CLOSE THE PREVIEW WINDOW

" NOT IN USE ANYMORE ..
"nnoremap <space> :call PreviewWord()<cr>

"DECLARATION OF A VARIABLE FOR THE WHOLE TAB:
"SO THAT WE CAN KNOW IF WE NEED TO CLOSE THE PREVIEW WINDOW (SAME WORD AGAIN)
let t:ptag_window_word = ""

func! PreviewWord()
	if &previewwindow			" don't do this in the preview window
		return
	endif
	"MAKE SURE THE WORD WE FOUND WILL BE CENTERED UPWISE IN WINDOW
	let saved_scrolloff=&scrolloff
	set scrolloff=6
	let word_to_be_ptaged = expand("<cword>")		" get the word under cursor
	if word_to_be_ptaged =~ '\a'			" if the word contains a letter
		if word_to_be_ptaged ==# t:ptag_window_word
			wincmd p 	"GOING BACK TO THE PREVIOUS WINDOW
			pclose	"CLOSING THE PREVIEW WINDOW
			let t:ptag_window_word = ""
			let scrolloff=saved_scrolloff
			return
		endif

		"DELETE ANY EXISTING HIGHLIGHT BEFORE SHOWING ANOTHER TAG
		"AND WILL CLOSE THE EXISTING WINDOW AND RETURN 
		silent! wincmd P			" jump to preview window
		if &previewwindow			" if we really get there...
			match none			" delete existing highlight
			wincmd p			" back to old window
		endif

		"TRY DISPLAYING A MATCHING TAG FOR THE WORD UNDER THE CURSOR
		"OPENS THE WINDOW AT THE VERY TOP
		try
			exe "topleft ptag " . word_to_be_ptaged
		catch
			return
		endtry

		silent wincmd P			" jump to preview window
		if &previewwindow		" if we really get there...
			if has("folding")		" first we don't want a closed fold
				:silent execute "normal zR"
			endif
			call search("$", "b")		" to end of previous line
			let t:ptag_window_word = substitute(word_to_be_ptaged, '\\', '\\\\', "")
			"CHECK THAT TEH PREVIOUS TIME WE CALLED THE FUNCTION IT WAS NOT THE EXACT SAME WORD
			"IF YES THEN CLOSE
			call search('\<\V' . t:ptag_window_word . '\>') "position cursor on match
			" Add a match highlight to the word at this position
			hi previewWord term=bold ctermbg=green ctermfg=black guibg=green
			exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
			wincmd p			" back to old window
		endif
	endif
	"let scrolloff=&saved_scrolloff
endfun

"FUNCTION USED WHILE EDITING A .SH FILE --> SEE AUTOCMANDS FOR .SH FILES
let t:panel_colors_opened_id = 0
function! Display_panel_colors()

	if t:panel_colors_opened_id > "0"
		execute win_id2win(t:panel_colors_opened_id) . 'wincmd c'
		let t:panel_colors_opened_id = 0
		return
	endif
	"essential to tell the command it is the end : ++eof= (and a <CR> is appended!)
	vertical botright terminal ++cols=30 ++eof= cat color_panel_cat_me
	setlocal nonumber
	let t:panel_colors_opened_id = win_getid()
	wincmd p

endfunction

"TODO WILL PRINT TODO AND DATE AND TIME
function! ToDoFunc()

	normal! k
	call DateAndTime()
	normal! I //TODO(
	normal! A) 

endfunction


" }}}
"------------------------------------------------------------------------------

"TO BE FINISHED

"make sure the functions in plugin are indexed with the SID THINGY

