{ pkgs, username, userEmail, ... }: {
  programs.git = {
    inherit userEmail;
    enable = true;
    userName = username;
    lfs.enable = true;
    delta.enable = true;
    ignores = [
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/*"
      "!.vscode/extensions.json"
      "!.vscode/launch.json"
      "!.vscode/settings.json"
      "!.vscode/tasks.json"
      "*.code-workspace"
      ".DS_Store"
      ".env"
      ".factorypath"
      ".idea"
      ".ionide"
      ".settings"
      ".vimrc.lua"
      ".vs"
      "Thumbs.db"
      "Thumbs.db:encryptable"
    ];
    aliases = {
      ignore = "!f() { curl -L -s https://www.gitignore.io/api/$@ ;}; f";
    };
    extraConfig = {
      core = {
        autocrlf = false;
        editor = "nvim";
        # fsmonitor = true;
        ignorecase = false;
        untrackedcache = true;
      };
      status.showUntrackedFiles = "all";
      color = { ui = "auto"; };
      init.defaultBranch = "main";
      commit.template = "${pkgs.writeText "committemplate" ''


        # = HEADER =================================================
        #
        # build: ---------------- changes that affect artifacts
        # feat: ----------------- add new feature
        # chore: ---------------- maintenance
        # fix: ------------------ bug fix
        # refactor: ------------- refactor
        # test: ----------------- test
        # style: ---------------- formatting
        # docs: ----------------- documents
        # perf: ----------------- improve performance
        # ci: ------------------- ci
        #
        # <type>(<scope>): <short summary>
        #   │       │             │
        #   │       │             └─> Summary in present tense.
        #   │       │                 Not capitalized.
        #   │       │                 No period at the end.
        #   │       │
        #   │       └─> Commit Scope: common|core|logic|...
        #   │
        #   └─> Commit Type: build|feat|chore|...
        #
        # = FOOTER (if exists) =====================================
        #
        # - BREAKING CHANGE: <breaking change summary>
        # - DEPRECATED: <what is deprecated>
        #
        # ==========================================================
      ''}";
    };
  };
  home.packages = with pkgs; [ ghq pre-commit gh ];
}
