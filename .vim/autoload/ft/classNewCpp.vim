"C++ CLASS GENERATOR: OPENING 2 NEW FILES
function! ft#classNewCpp#ClassNewCpp(ClassName)
	"==================  editing source file =================================
	execute "vsp %:h/" . a:ClassName . ".cpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:
	:execute "normal! a" . "//#include <iostream>\<cr>"
	:execute "normal! a#include \"" . a:ClassName . ".hpp\"\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "::" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>return ;\<cr>}\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "::~" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>return ;\<cr>}\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "::" . a:ClassName ."(". a:ClassName . " const &src)\<cr>{\<cr>" 
	:execute "normal! a\<tab>*this = src;\<cr>return ;\<cr>}\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "\<tab>&\<cr>" . a:ClassName. "::operator=(" . a:ClassName . " const &rhs)\<cr>{\<cr>"
	:execute "normal! a\<tab>if (this != &rhs)\<cr>{\<cr>;//put code here\<cr>}\<cr>"
	:execute "normal! a\<tab>return *this;\<cr>}\<cr>\<cr>"
	:execute "normal! a//std::ostream\<tab>&\<cr>//operator<<(std::ostream &o, " . a:ClassName . " const &rhs)\<cr>//{\<cr>"
	:execute "normal! a//\<tab>o << rhs.getValue();\<cr>"
	:execute "normal! a//\<tab>return o;\<cr>//}\<cr>\<cr>"
	"Comment this line if you dont want to save files straight away.
	":execute 'write'

	"==================  editing header file =================================
	execute "vsp %:h/" . a:ClassName . ".hpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:
	:execute "normal! a" . "//#include <iostream>\<cr>\<cr>"
	:execute "normal! a" . "class " . a:ClassName ."\<cr>{\<cr>" 
	:execute "normal! a\<tab>public:\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "(void);\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "(" . a:ClassName . " const &src);\<cr>"
	:execute "normal! avirtual\<tab>~" . a:ClassName . "(void);\<cr>\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . " &\<tab>operator=(" . a:ClassName . " const &rhs);\<cr>\<cr>"
	:execute "normal! a\<tab>protected:\<cr>\<cr>"
	:execute "normal! a\<tab>private:\<cr>\<cr>"
	:execute "normal! a};\<cr>\<cr>"
	:execute "normal! a//std::ostream\<tab>&operator<<(std::ostream &o, " . a:ClassName . " const &rhs);"
	:execute "normal! 3ka\<tab>\<tab>"
	"Comment out this line if you dont want to start in insert mode
	:startinsert!
	"Comment this line if you dont want to save files straight away.
	:execute 'write'
endfunction
