"GLOBAL VARIABLE TO KEEP TRACK OF THE WINDOW OPENED (TARGET) BY THE QUICKFIX
let g:quickfix_target_window = 0
"TWO GLOBAL VARIABLES TO SAVE CURRENT WORKING WINDOW BEFORE THE QUICKFIX CALL
let g:window_before_quickfix = 0
"GLOBAL TO KEEP TRACK OF THE QIUCKFIX WINDOW
let g:quickfix_window_id = 0


"	COMMANDS WHILE IN THE QUICKFIX WINDOW
"EDIT - GO TO CURENT - NEXT - PREVIOUS - QUIT 
"NOTE <LEADER>Q AVAILABLE FROM EVERYFILE ANYWHERE
augroup quickfix_manage_window
	autocmd!
	autocmd FileType qf nnoremap <buffer> <enter> :call Preview_quickfix("enter")<cr>
	autocmd FileType qf nnoremap <buffer> <space> :call Preview_quickfix("preview")<cr>
	autocmd FileType qf nnoremap <buffer> j :call Preview_quickfix("j")<cr>
	autocmd FileType qf nnoremap <buffer> k :call Preview_quickfix("k")<cr>
	autocmd FileType qf nnoremap <buffer> q :call Preview_quickfix("quit")<cr>

	autocmd BufNewFile,BufRead * nnoremap <buffer> <leader>q :call Preview_quickfix("quit")<cr>
augroup END


"THIS FUNCTION SHOULD BE CALLED AT THE VERY BEGGINING OF THE QUICKFIX USE
function! Quickfix_start()
	let g:quickfix_target_window = 0
	let g:window_before_quickfix = win_getid()
	botright 6 copen
	let g:quickfix_window_id = win_getid()
endfunction

"THIS FUNCTION SHOULD BE USED AT HE VERY END OF THE QUICKFIX USE
function! Quickfix_end()
	if g:quickfix_window_id > 0
		let g:quickfix_window_id = 0
		cclose
		execute win_id2win(g:window_before_quickfix) . "wincmd w"
		sleep 500m
		:call Flash()
	endif
endfunction


"THIS FUNCTION WILL ACT ON DIFFERENT MODES:
"ENTER AND EDIT |OR| PREVIEW OCCURENCE  -->  QUIT AT ALL TIME USING <LEADER>q
"NOTE: USEFULL FEATURE: PRESS <SPACE> TO SPOT THE LINE
"NOTE2: IF EXISTING, CLOSES THE PREVISOUSLY OPENED WINDOW BY QUICKFIX.
"	EXECPT IF IT IS THE VERY FIRST WINDOW WE WERE WORKING ON
function! Preview_quickfix(mode)

	if ((g:quickfix_target_window != g:window_before_quickfix) && (win_id2win(g:quickfix_target_window) > 0))
		execute win_id2win(g:quickfix_target_window) . 'wincmd c'
	endif
	if a:mode ==# 'enter'
		"CONTROLS THE BEHAVIOR WHEN SWITCHING BUFFERS, checked by quickfix COMMANDS copen
		set switchbuf=useopen,usetab,newtab
		:call Open_quickfix_target_window("cc")
	elseif a:mode ==# 'quit'
		set switchbuf=useopen,usetab,newtab
		:call Quickfix_end()
	else
		set switchbuf=split
	    	if a:mode ==# 'preview'
			:call Open_quickfix_target_window("cc")
		elseif a:mode ==# 'k'
			:call Open_quickfix_target_window("cprevious")
		elseif a:mode ==# 'j'
			:call Open_quickfix_target_window("cnext")
		endif
		execute win_id2win(g:quickfix_window_id) . "wincmd w"
	endif
endfunction

"THIS FUNCTION WILL OPEN THE WINDOW IT SAVES THE WINDOW'S INDEX FOR NEXT RUN,
"OPENS FOLDS, THEN BLINKS THE LINE
function! Open_quickfix_target_window(target)
	execute a:target
	let g:quickfix_target_window = win_getid()
	"UNFOLD if folded
	if has("folding")
		:silent! .foldopen
	endif
	:call Flash()
endfunction
