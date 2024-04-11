{ pkgs, lib, ... }: {
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";
      shellAliases = let
        ghq = "${pkgs.ghq}/bin/ghq";
        fzf = "${pkgs.fzf}/bin/fzf";
        peco = "${pkgs.peco}/bin/peco";
        bat = "${pkgs.bat}/bin/bat";
        eza = "${pkgs.eza}/bin/eza";
      in {
        ".." = "cd ..";
        g = "cd $(${ghq} root)/$(${ghq} list | ${fzf})";
        gg = "${ghq} get";
        cat = "${bat}";
        ls = "${eza}";
        tree = "${eza} -T";
      };
      initExtraFirst = ''
        HISTSIZE=100000
        SAVEHIST=1000000
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_ALL_DUPS
        setopt share_history
        setopt hist_reduce_blanks
        '';
      initExtra = ''
        export NLS_LANG=Japanese_Japan.AL32UTF8
        export GOPATH=$HOME/go
        export NODE_PATH=~/.npm-packages/lib/node_modules
        export PATH=$GOPATH/bin:$PATH
        export PATH=~/.npm-packages/bin:$PATH
        export PATH=$PATH:/opt/homebrew/bin

        # pure
        fpath+=("$HOME/.zsh/plugins/pure/share/zsh/site-functions")
        autoload -U promptinit; promptinit
        zstyle :prompt:error color '#F5C77E'
        zstyle :prompt:success color '#87CEEB'
        PURE_PROMPT_SYMBOL="❯❯❯"

        prompt pure
      '';
      profileExtra = "";
      plugins = [{
        name = "pure";
        src = pkgs.pure-prompt;
        file = "share/zsh/site-functions";
      }];
    };
  };
}
