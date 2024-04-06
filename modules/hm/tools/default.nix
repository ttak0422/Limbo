_: {
  flake.nixosModules.hm-tools = { pkgs, ... }:
    let inherit (pkgs.stdenv) isDarwin;
    in {
      imports = [ ./direnv.nix ./fzf.nix ./pet.nix ];
      home.packages = with pkgs;
        [
          bat # ------------ cat clone
          bottom # --------- system monitor
          commitizen # ----- git commit helper
          coreutils-full # - cat, ls, mv, wget, ...
          d2 # ------------- modern diagram
          eza # ------------ ls clone
          fd # ------------- find clone
          figlet # --------- ascii
          gnugrep
          gnused
          graphviz # ------- dot
          grex # ----------- derive regex from examples
          hey # ------------ load test tool
          htop # ----------- top clone
          jq # ------------- JSON processor
          lazygit # -------- git tui
          mkcert # --------- create local CA
          mysql80
          neofetch # ------- system information tool
          nix-prefetch-git
          nix-prefetch-github
          onefetch
          peco
          pkg-config # ----- compile helper
          plantuml # ------- uml
          pwgen # ---------- password generator
          ranger # --------- cui filer
          ripgrep # -------- grep clone
          rlwrap # --------- readline wrapper
          sd # ------------- sed clone
          sqlite # --------- db engine
          taskwarrior
          taskwarrior-tui
          tealdeer # ------- tldr: complete `man` command
          timewarrior
          tokei # ---------- code count
          viddy # ---------- watch
          wget # ----------- GNU Wget
          yq # ------------- YAML/XML/TOML processor
          zoxide # --------- fast cd
        ] ++ (if isDarwin then
          [
            pkgs.pkgs-x86_64-darwin.oracle-instantclient # sqlplus, ...
          ]
        else
          [
            # WIP
            # pkgs.oracle-instantclient # sqlplus, ...
          ]);
    };
}
