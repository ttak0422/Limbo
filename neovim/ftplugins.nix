{ pkgs, ... }:
let inherit (builtins) readFile;
in {
  qf = with pkgs.vimPlugins; ''
    silent source ${nvim-bqf}/after/ftplugin/qf/bqf.vim
  '';
  ddu-ff = readFile ./vim/ddu-ff.vim;
  ddu-ff-filter = readFile ./vim/ddu-ff-filter.vim;
}
