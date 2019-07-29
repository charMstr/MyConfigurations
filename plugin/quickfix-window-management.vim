"MAPPING FOR THE QUICKFIX WINDOW TOGGLE
nnoremap <leader>qq :call QuickFixToggle()<cr>

"GLOBAL VARIABLE TO KEEP TRACK OF THE QUICKFIX WINDOW STATE
let g:quickfix_is_open = 0

"FUNCTION THAT TOGGLES THE QUICKFIX WINDOW: OPEN / CLOSE
"AND LETS YOU COME NBACK TO THE ORIGINAL WINDOW
function! QuickFixToggle()
	if g:quickfix_is_open
		call GetBackToCurrentTab()
		cclose
		let g:quickfix_is_open = 0
		execute g:quickfix_return_to_window . "wincmd w"
	else
		let g:quickfix_return_to_window = winnr()
		call GetBackToCurrentTab()
		execute "normal! \<c-l>"
		botright 6 copen
		let g:quickfix_is_open = 1
	endif
endfunction


"GO TO CURENT - NEXT - PREVIOUS QUICKFIX WINDOW
nnoremap <leader>qc :cc<cr>
nnoremap <leader>qk :cprevious<cr>
nnoremap <leader>qj :cnext<cr>

"CONTROLS THE BEHAVIOR WHEN SWITCHING BUFFERS, check by quickfix COMMANDS copen
let &switchbuf = "useopen,usetab,newtab"

let g:quickfix_return_to_tab = 0
function! GetBackToCurrentTab()
	if g:quickfix_is_open
		execute g:quickfix_return_to_tab . "tabo"
	else
		let g:quickfix_return_to_tab = tabpagenr()
	endif
endfunction
