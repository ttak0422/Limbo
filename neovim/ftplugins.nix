{ ... }:
let inherit (builtins) readFile;
in {
  ddu-ff = readFile ./vim/ddu-ff.vim;
  ddu-ff-filter = readFile ./vim/ddu-ff-filter.vim;
}
