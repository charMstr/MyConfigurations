nnoremap <leader>g :set operatorfunc=GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call GrepOperator(visualmode())<cr>

function! GrepOperator(type)
	if a:type ==# 'v'
		execute "normal! `<v`>y"
"NB: GREP DOESNT SEARCH ON MULTIPLE LINES BY DEFAULT, SO WE WONT GREP
" USING 'V' OR 'LINE' 
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	silent execute "grep! -R " . shellescape(@") . " ." 
	execute "normal! \<c-l>"
	botright 6 copen
endfunction
