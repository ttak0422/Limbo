cabbrev <expr> r getcmdtype() .. getcmdline() ==# ":r" ? [getchar(), ""][1] .. "%s//g<Left><Left>" : (getcmdline() ==# "'<,'>r" ?  [getchar(), ""][1] .. "s//g<Left><Left>" : "r")
