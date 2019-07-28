"THIS CHANGES THE <LEADER>G COMBINAISON INTO THRE GREP OPERATOR
" note: it searches into the current foler ( " .")
" note2: '*' is replaced by the character group regex syntax: '[*]'
" note3: GREP DOESNT SEARCH ON MULTIPLE LINES BY DEFAULT, SO WE WONT GREP USING 'V' OR 'line' 

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
	call QuickFixToggle()

	let @@ = saved_unnamed_register
endfunction
