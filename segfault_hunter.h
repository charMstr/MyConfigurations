//this header create will contain necessary defines and a global variable for the
//automatically generated if(DEBUG) statements whle debugging

#ifndef SEGFAULT_HUNTER_H
# define SEGFAULT_HUNTER_H

# include <stdio.h>
# define DEBUG 1
# define IF_DEBUG_COLOR 33
# define WHILE_DEBUG_COLOR 34
# define FUNC_DEBUG_COLOR 35
# define GLOBAL_DEBUG_COLOR 140
# define GLOBAL_DEBUG_VAR global_debug_var

int GLOBAL_DEBUG_VAR = 0;

#endif
