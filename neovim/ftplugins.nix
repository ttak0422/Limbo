{ pkgs, ... }:
let
  inherit (builtins) readFile toJSON;
in
{
  norg = ''
    setlocal noswapfile
  '';
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
  haskell = with pkgs.vimPlugins; ''
    lua << EOF
    require("haskell-tools")
    dofile("${haskell-tools-nvim}/ftplugin/haskell.lua")
    EOF
  '';
  lhaskell = with pkgs.vimPlugins; ''
    lua << EOF
    require("haskell-tools")
    dofile("${haskell-tools-nvim}/ftplugin/lhaskell.lua")
    EOF
  '';
  cabal = with pkgs.vimPlugins; ''
    lua << EOF
    require("haskell-tools")
    dofile("${haskell-tools-nvim}/ftplugin/cabal.lua")
    EOF
  '';
  cabalproject = with pkgs.vimPlugins; ''
    lua << EOF
    require("haskell-tools")
    dofile("${haskell-tools-nvim}/ftplugin/cabalproject.lua")
    EOF
  '';
  java =
    let
      jdtls = pkgs.jdt-language-server;
      args = toJSON {
        runtimes = [
          {
            name = "JavaSE-11";
            path = pkgs.jdk11;
          }
          {
            name = "JavaSE-17";
            path = pkgs.jdk17;
            default = true;
          }
        ];
        on_attach_path = ./lua/on_attach.lua;
        capabilities_path = ./lua/capabilities.lua;
        java_path = "${pkgs.jdk17}/bin/java";
        # jdtls_config_path = "${jdtls}/share/config";
        jdtls_config_path =
          let
            systemPath = if pkgs.stdenv.isDarwin then "config_mac" else "config/linux";
          in
          "${jdtls}/share/java/jdtls/${systemPath}";

        lombok_jar_path = "${pkgs.lombok}/share/java/lombok.jar";
        jdtls_jar_pattern = "${jdtls}/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar";
        java_debug_jar_pattern = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar";
        java_test_jar_pattern = "${pkgs.vscode-extensions.vscjava.vscode-java-test}/share/vscode/extensions/vscjava.vscode-java-test/server/*.jar";
        jol_jar_path = pkgs.javaPackages.jol;
      };
    in
    ''
      lua << EOF
        local args = vim.json.decode([[${args}]])
        ${readFile ./lua/java.lua}
      EOF
    '';
  ddu-ff = readFile ./vim/ddu-ff.vim;
  ddu-ff-filter = readFile ./vim/ddu-ff-filter.vim;
  gina-blame = readFile ./vim/gina-blame.vim;
}
