"C++ CLASS GENERATOR: OPENING 2 NEW FILES
function! ft#classNewCpp#ClassNewCpp(ClassName)
	"==================  editing source file =================================
	execute "vsp %:h/" . a:ClassName . ".cpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:
	:execute "normal! a#include \"" . a:ClassName . ".hpp\"\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "::" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>return ;\<cr>"
	:execute "normal! a}\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "::~" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>return ;\<cr>"
	:execute "normal! a}"
	"Comment this line if you dont want to save files straight away.
	":execute 'write'

	"==================  editing header file =================================
	execute "vsp %:h/" . a:ClassName . ".hpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:
	:execute "normal! a" . "class " . a:ClassName ."\<cr>{\<cr>" 
	:execute "normal! a\<tab>public:\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "(void);\<cr>"
	:execute "normal! a\<tab>\<tab>~" . a:ClassName . "(void);\<cr>\<cr>"
	:execute "normal! a\<tab>protected:\<cr>\<cr>"
	:execute "normal! a\<tab>private:\<cr>\<cr>"
	:execute "normal! a};"
	:execute "normal! ka\<tab>\<tab>"
	"Comment out this line if you dont want to start in insert mode
	:startinsert!
	"Comment this line if you dont want to save files straight away.
	:execute 'write'
endfunction
