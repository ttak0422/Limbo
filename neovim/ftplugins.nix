{ pkgs, ... }:
let inherit (builtins) readFile;
in {
  qf = with pkgs.vimPlugins; ''
    silent source ${nvim-bqf}/after/ftplugin/qf/bqf.vim
  '';
  rust = with pkgs.vimPlugins; ''
    silent source ${rustaceanvim}/ftplugin/rust.vim
    lua << EOF
    -- Hack: load rustaceanvim before setup
    require("rustaceanvim")
    dofile("${rustaceanvim}/ftplugin/rust.lua")
    EOF
  '';
  ddu-ff = readFile ./vim/ddu-ff.vim;
  ddu-ff-filter = readFile ./vim/ddu-ff-filter.vim;
  gina-blame = readFile ./vim/gina-blame.vim;
}
