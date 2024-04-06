let ignores =
      [ "*~"
      , "*.swp"
      , "*.swo"
      , "!.vscode/extensions.json"
      , "!.vscode/launch.json"
      , "!.vscode/settings.json"
      , "!.vscode/tasks.json"
      , "*.code-workspace"
      , ".DS_Store"
      , ".env"
      , ".factorypath"
      , ".idea"
      , ".ionide"
      , ".settings"
      , ".vimrc.lua"
      , ".vs"
      , ".vscode/*"
      , "Thumbs.db"
      , "Thumbs.db:encryptable"
      ]

let template =
      ''


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
      ''

in  { ignores, template }
