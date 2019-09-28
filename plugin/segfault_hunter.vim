"this pluggin will insert in the text a colored printf that will say the name
"of the previous function / while / if / for.
"it searches backwards for a '(' and check that ther is a keyword in front of
"it. (see dictionnary in fucntion)
"
"improvements to be made:
" - make a mapping that will copy in the current directory
"the segfault_hunter.h file, and then automatically include it.
"
" - make a mapping that will search the whole fie and clean each of this
"inserted printfs
"
" - make sure it recognises and discards the if(DEBUG) when searching backwards
" 
" - maybe make a function hat scans the text and inserts automaticcaly everywhere
"it should then check that the functions are not prototypes

"make the following not an autocommand but something hat happens on the first time
"then gets cleaned when using he clean-all keymapping
	"THIS AUTOCOMMAND IS ESSENTIAL BECAUSE IT COPIES THE SEGFAULT_HUNTER.H FILE IN THE CURRENT DIRECTORY 
	"autocmd BufNewFile,BufRead *.c silent! !cp ~/Myconfigurations/segfault_hunter.h ./
	"autocmd VimLeave *.c silent! !rm segfault_hunter.h
	
"this global will be set the very first time we call InsertDebugPrintf()
"--> include the .h and copies .h in cur. dir.
" then it will be unset when we use the function RemoveDebugPrintf()
let g:debug_hunter_activated = 0

function! InsertDebugPrintf()

	"SAVES THE CURRENT POSITION
	let save_cursor = getcurpos()	
	let debug_line_start=line('.')

	"ENTER THIS IF THE VERY FIRST TIME WE IMSERT A DEBUGGING PRINTF
	if !g:debug_hunter_activated
		"INSERT INCLUDE AT THE FIRST EMPTY LINE OF FILE
		execute "normal! gg" | exe "normal! /^$" | exe "normal! O#include \"segfault_hunter.h\""
		"COPY SEGFAULT_HUNTER.H FILE IN CURRENT LOCAION
		silent! !cp ~/MyConfigurations/segfault_hunter.h ./
		"REFRESH SCREEN AFTER EXTERNAL TERMINAL COMMAND
		execute "normal! \<c-l>"
		let g:debug_hunter_activated = 1
	endif

	"CREATE A DEBUG DICTIONNARY
	let dic_debug_key_words = {'while': 182, 'if': 40, 'for': 21, 'void': 75, 'int': 39, 'char': 14, 'long': 208, 't_list': 198}

	"MOVE DOWN A LINE SO IT INCLUDES THE CURRENT LINE WHILE SEARCHING BACKWARS
	exe "normal! j"

	"SEARCH BACK UNTIL WORD IS IN DICTIONNARY
	let key_word_for_debug = ""
	:while !has_key(dic_debug_key_words, key_word_for_debug)
		?(
		"GET THE WORD UNDER CURSOR
		let key_word_for_debug = expand("<cword>")
		"CHECK IF THE POSITION WE JUST MOVED TO IS INSIDE OR RIGHT AFTER CURLY BRACES
		let display_inside_or_after = Inside_or_after_brackets(debug_line_start,line('.'))
		if display_inside_or_after == 0 
			let key_word_for_debug = "KEEP SEARCHING"
		endif
	:endwhile

	"GET THE NUMBER MATCHING THE KEYWORD IN DICTIONNARY FOR COLOR_CODE IN THE PRINTF
	let choosen_color = get(dic_debug_key_words, key_word_for_debug)
	"CHOOSE TO DISPLAY INSIDE OR AFTER IN THE SENTENCE WE PRINT FOR DEBUG
	if display_inside_or_after == 2
		let inside_or_after = "[INSIDE]"
	else	
		let inside_or_after = "[AFTER]"
	endif
	echom inside_or_after

	"COPY THE CURRENT LINE WITHOUT THE TRAILING NEW LINE
	:exe "normal! v$hy"	

	"RESTORE CURSOR TO INITIAL POSITION
	call setpos('.', save_cursor)

	"INSERT THE PRINTF
	exe "normal! oif (SEGFAULT_HUNTER)\<esc>oprintf(\"\\033[38;5;%dm\\t[%d] --> "
	"PASTE THE LINE WE YANKED HERE SO WE KNOW WHERE WE ARE
	exe "normal! a\\033[m\\033[38;5;%dm \<esc>pA\\033[38;5;%dm"
	"INSERT THE WORD INSIDE OR AFTER DEPENDING OF THE MATCHING CURLY BRACES
	:put =inside_or_after "this prints the word itself
	"MERGE THE INSIDE_OR_AFTER WITH THE PREVIOUS LINE
	exe "normal! kJ$"
	exe "normal! a\\033[m\\n\", SEGF_HUNTER_COLOR, SEGFAULT_HUNTER_G++, "
	"INSERT THE COLOR CODE DEPENDING ON THE KEY WORD
	:put =choosen_color
	"MERGE THE CHOOSEN_COLOR WITH THE PREVIOUS LINE
	exe "normal! kJ$"
	exe "normal! a, SEGF_HUNTER_COLOR);"

	"RESTORE CURSOR TO INITIAL POSITION
	call setpos('.', save_cursor)
endfunction

"THIS FUNCTION TRYES TO UNDERSTAND IF WE ARE INSIDE OR RIGHT AFTER MATCHING CURLY BRACES
"NOTE: TARGET_LINE NEEDS TO BE BEFORE THE INITIAL_LINE(SMALLER OR EQUAL) SO BASICALLY THE RESULT OF A BACKWARDS SEARCH
function! Inside_or_after_brackets(initial_line,target_line)
	let save_cursor = getcurpos()	
	
	"INITIALISE VARIABLE, SEARCH WITHIN A RANGE, THEN INCREASE VARIABLE ON EACH OCURENCE
	silent! execute 'let braces_c = 0 | ' . a:target_line . ',' . a:initial_line . 'g/}/ let braces_c = braces_c + 1'
	silent! execute 'let braces_o = 0 | ' . a:target_line . ',' . a:initial_line . 'g/{/ let braces_o = braces_o + 1'

	"RESTORE CURSOR TO POSITION
	call setpos('.', save_cursor)
	
	if braces_c == braces_o && braces_c != 0
		return 1 "means we are just AFTER the matching brackets
	elseif braces_c <= braces_o
		return 2 "means we are INSIDE a matching pair of brackets
	else
		return 0 	"means we are past something that was further out/up. keep searching
					"the closing curly braces number was bigger than the openings's one
	endif
endfunction

"THIS FUNTCION WILL REMOVE EVERYTHING AT ONCE AND EVEN REMOVE THE INCLUDE AND
" THE .H FILE ITSELF
function! RemoveDebugPrintf()
	exe "normal! gg"
	"OPEN ALL THE FOLDS BEFORE SEARCH AND DELETE ACTIONS (WAS ACTING WEIRD)
	exe "normal! zR"
	g/segfault_hunter/ exe "normal! dd"
	g/SEGFAULT_HUNTER/ exe "normal! dd"
	silent! !rm segfault_hunter.h
	"REFRESH SCREEN AFTER EXTERAL COMMAND
	execute "normal! \<c-l>"
	"SET BACK THE GLOBAL VARIABLE AFTER REMOVING THE INCLUDES AND THE .H
	let g:debug_hunter_activated = 0
endfunction
