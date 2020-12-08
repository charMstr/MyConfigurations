"THIS CHANGES THE <LEADER>G COMBINAISON INTO THRE GREP OPERATOR
"USAGE: IF SOME TEXT IS SELECTED VISUALLY: IT SEARCHES IT
"USAGE: IF IN NORMAL MODE, IT IS OPERATOR PENDING --> EXAMPLE: <LEADER>Giw --> searches in word
" NOTE: IT SEARCHES INTO THE CURRENT FOLER ( " .") AND GOEA DOWN RECURCIVELY
" NOTE2: '*' IS REPLACED BY THE CHARACTER GROUP REGEX SYNTAX: '[*]'
" NOTE3: GREP DOESNT SEARCH ON MULTIPLE LINES BY DEFAULT, SO WE WONT GREP USING 'V' OR 'LINE' 

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
	let saved_unnamed_register = @@

	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[y`]"
	else
		return
	endif

	silent execute "grep! -R " . shellescape(substitute(expand(@"), "*", "[*]", "g")) . " ." 
	"THIS WILL REFRESH THE SCRENN IF MESSED UP
	execute "normal! \<c-l>"
	call Quickfix_start()
	
	let @@ = saved_unnamed_register
endfunction

