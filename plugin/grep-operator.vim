"THIS CHANGES THE <LEADER>G COMBINAISON INTO THRE GREP OPERATOR
" note: it searches into the current foler ( " .")
" note2: '*' is replaced by the character group regex syntax: '[*]'
" note3: GREP DOESNT SEARCH ON MULTIPLE LINES BY DEFAULT, SO WE WONT GREP USING 'V' OR 'line' 

nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	silent execute "grep! -R " . shellescape(substitute(expand(@"), "*", "[*]", "g")) . " ." 
	execute "normal! \<c-l>"
	botright 6 copen
endfunction

