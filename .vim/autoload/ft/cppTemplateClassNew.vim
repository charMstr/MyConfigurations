"C++ TEMPLATED CLASS GENERATOR: OPENING 1 NEW FILE
function! ft#cppTemplateClassNew#CppTemplateClassNew(ClassName)
	"==================  opening/creating file ====-===========================
	execute "vsp %:h/" . a:ClassName . ".template.hpp"
	"At this stage the autocomands for this filetype are done.
	"	example: inserting the header, and the ifndef... Then:

	:execute "normal! a" . "//#include <iostream>\<cr>\<cr>"
	"==================  inserting class definition ===========================
	:execute "normal! I/* ****************************************************************************\<cr>" 
	:execute "normal! I** HERE definition of template class: " . a:ClassName ."\<cr>" 
	:execute "normal! I******************************************************************************/\<cr>\<cr>\<esc>S" 
	:execute "normal! a" . "template < typename T >\<cr>" 
	:execute "normal! a" . "class " . a:ClassName ."\<cr>{\<cr>" 
	:execute "normal! a\<tab>public:\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "<T>(void);\<cr>"
	:execute "normal! avirtual\<tab>~" . a:ClassName . "<T>(void);\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . "<T>(" . a:ClassName . "<T> const &src);\<cr>"
	:execute "normal! a\<tab>\<tab>" . a:ClassName . " &\<tab>operator=(" . a:ClassName . " const &rhs);\<cr>\<cr>"
	:execute "normal! a\<tab>protected:\<cr>\<cr>"
	:execute "normal! a\<tab>private:\<cr>\<cr>"
	:execute "normal! a};\<cr>\<cr>"
	
	"==================  inserting source code ================================
	:execute "normal! I/* ****************************************************************************\<cr>" 
	:execute "normal! I** HERE (1/2) source code for template class: " . a:ClassName ."\<cr>" 
	:execute "normal! I******************************************************************************/\<cr>\<cr>\<esc>S" 

	"constructor	
	:execute "normal! a" . "template < typename T >\<cr>" 
	:execute "normal! a" . a:ClassName . "<T>::" . a:ClassName . "(void)\<cr>"
	:execute "normal! a{\<cr>"
	:execute "normal! a\<tab>//std::cout << \"\\033[33mconstructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a}\<cr>\<cr>"

	"destructor
	:execute "normal! a" . "template < typename T >\<cr>" 
	:execute "normal! a" . a:ClassName . "<T>::~" . a:ClassName . "(void)\<cr>"
	:execute "normal! a{\<cr>"
	:execute "normal! a\<tab>//std::cout << \"\\033[31m[~]\\033[33mdestructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a}\<cr>\<cr>"

	"copy constructor	
	:execute "normal! a" . "template < typename T >\<cr>" 
	:execute "normal! a" . a:ClassName . "<T>::" . a:ClassName . "(". a:ClassName . "<T> const &src)\<cr>"
	:execute "normal! a{\<cr>"
	:execute "normal! a\<tab>//std::cout << \"\\033[33m[COPY]constructor called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a\<tab>*this = src;\<cr>"
	:execute "normal! a}\<cr>\<cr>"

	"= operator overload
	:execute "normal! a" . "template < typename T >\<cr>" 
	:execute "normal! a" . a:ClassName . "<T> &\<cr>"
	:execute "normal! a" . a:ClassName . "<T>::operator=(". a:ClassName . "<T> const &rhs)\<cr>"
	:execute "normal! a{\<cr>"
	:execute "normal! a\<tab>//std::cout << \"\\033[33m'=' operator called for "
	:execute "normal! a" . a:ClassName . "\\033[0m\" << std::endl;\<cr>"
	:execute "normal! a\<tab>if (this != &rhs)\<cr>{\<cr>;//put copy code here\<cr>"
	:execute "normal! a}\<cr>return *this;\<cr>}\<cr>\<cr>"

	"<< operator overload
	:execute "normal! a" . "//template < typename T >\<cr>" 
	:execute "normal! a//std::ostream\<tab>&operator<<(std::ostream &o, " . a:ClassName . "<T> const &rhs)\<cr>"
	:execute "normal! a//{\<cr>//\<tab>o << getValue();\<cr>"
	:execute "normal! a//\<tab>return o;\<cr>"
	:execute "normal! a//}\<cr>\<cr>"

	"==================  inserting source code ================================
	:execute "normal! I/* ****************************************************************************\<cr>" 
	:execute "normal! I** HERE (2/2) source code for template class: " . a:ClassName ."\<cr>" 
	:execute "normal! I******************************************************************************/\<cr>\<esc>S" 

	"place cursor
	":execute "normal! 4ka\<tab>\<tab>"
	"Comment out this line if you dont want to start in insert mode
	":startinsert!
	"Comment this line if you dont want to save files straight away.
	:execute 'write'
endfunction
