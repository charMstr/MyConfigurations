"this file will overrule all default file type checks for *.hpp

"note1:	Note that there is no "augroup" command, this has already been done
"		when sourcing your file.
"note2:	The files in the "ftdetect" directory are used after all the default
"		checks, thus they can overrule a previously detected file type.

au BufRead,BufNewFile *.h		set filetype=h
