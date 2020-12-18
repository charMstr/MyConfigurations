"C++ CLASS GENERATOR: OPENING 2 NEW FILES
function! ft#cppClassNew#CppClassNew(ClassName)
	"==================  editing source file =================================
	execute "vsp %:h/" . a:ClassName . ".cpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:
	:execute "normal! a" . "//#include <iostream>\<cr>"
	:execute "normal! a#include \"" . a:ClassName . ".hpp\"\<cr>\<cr>"

	"constructor
	:execute "normal! a" . a:ClassName . "::" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>//std::cout << \"\\033[33mconstructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a\<tab>return ;\<cr>}\<cr>\<cr>"

	"destructor
	:execute "normal! a" . a:ClassName . "::~" . a:ClassName ."(void)\<cr>{\<cr>" 
	:execute "normal! a\<tab>//std::cout << \"\\033[31m[~]\\033[33mdestructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a\<tab>return ;\<cr>}\<cr>\<cr>"

	"copy constructor
	:execute "normal! a" . a:ClassName . "::" . a:ClassName ."(". a:ClassName . " const &src)\<cr>{\<cr>" 
	:execute "normal! a\<tab>//std::cout << \"\\033[33m[COPY]constructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"

	"= operator overload
	:execute "normal! a\<tab>*this = src;\<cr>return ;\<cr>}\<cr>\<cr>"
	:execute "normal! a" . a:ClassName . "\<tab>&\<cr>" . a:ClassName. "::operator=(" . a:ClassName . " const &rhs)\<cr>{\<cr>"
	:execute "normal! a\<tab>//std::cout << \"\\033[33m'=' operator called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a\<tab>if (this != &rhs)\<cr>{\<cr>;//put code here\<cr>}\<cr>"
	:execute "normal! a\<tab>return *this;\<cr>}\<cr>\<cr>"

	"<< operator
	:execute "normal! a//std::ostream\<tab>&\<cr>//operator<<(std::ostream &o, " . a:ClassName . " const &rhs)\<cr>//{\<cr>"
	:execute "normal! a//\<tab>return rhs.Serialize(o);\<cr>//}\<cr>\<cr>"
	:execute "normal! a//std::ostream\<tab>&\<cr>//" . a:ClassName . "::Serialize(std::ostream &o) const\<cr>"
	:execute "normal! a//{\<cr>//\<tab>o << getName();//or something else\<cr>"
	:execute "normal! a//\<tab>return o;\<cr>//\<tab>//return BASE::Serialize(o) << getName()...;\<cr>//}\<cr>"
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
	:execute "normal! avirtual\<tab>~" . a:ClassName . "(void);\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "(" . a:ClassName . " const &src);\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . " &\<tab>operator=(" . a:ClassName . " const &rhs);\<cr>\<cr>"
	:execute "normal! a\<tab>//function to serialize my output from the << overload\<cr>"
	:execute "normal! a\<tab>\<tab>//virtual std::ostream & Serialize(std::ostream &o) const;\<cr>\<cr>"
	:execute "normal! a\<tab>protected:\<cr>\<cr>"
	:execute "normal! a\<tab>private:\<cr>\<cr>"
	:execute "normal! a};\<cr>\<cr>"
	:execute "normal! a//std::ostream\<tab>&operator<<(std::ostream &o, " . a:ClassName . " const &rhs);"
	:execute "normal! 3ka\<tab>\<tab>"
	"Comment out this line if you dont want to start in insert mode
	":startinsert!
	"Comment this line if you dont want to save files straight away.
	:execute 'write'
endfunction
