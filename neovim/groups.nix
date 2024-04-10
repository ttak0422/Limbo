{ pkgs, lib }:
let
  inherit (builtins) readFile;
  inherit (lib.strings) concatStringsSep;
in with pkgs.vimPlugins; {
  lir = {
    name = "lir";
    plugins = [
      {
        plugin = lir-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/lir.lua;
        };
        dependPlugins = [ plenary-nvim nvim-web-devicons ];
      }
      {
        plugin = lir-git-status-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/lir-git-status.lua;
        };
        dependPlugins = [ plenary-nvim lir-nvim ];
      }
    ];
    onModules = [ "lir.float" ];
    onEvents = [ "CmdlineEnter" ];
  };
  fzf = {
    name = "fzf";
    preConfig = ''
      source ${pkgs.fzf}/share/nvim/site/plugin/fzf.vim
    '';
  };
  cmdlineHook = {
    name = "cmdlineHook";
    postConfig = {
      language = "lua";
      code = readFile ./lua/cmdline_hook.lua;
      args = {
        viml = ./vim/cmdline-hook.vim;
        cabbrev = ./vim/cabbrev.vim;
      };
    };
    onEvents = [ "CmdlineEnter" ];
  };
  bufferHook = {
    name = "bufferHook";
    plugins = [ ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/bufferHook.lua;
    };
    onEvents = [ "BufAdd" "BufNew" ];
  };
  editHook = {
    name = "editHook";
    plugins = [
      # {
      #   # Lightweight yet powerful formatter plugin for Neovim
      #   plugin = conform-nvim;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./lua/conform.lua;
      #   };
      #   extraPackages = with pkgs; [
      #     # Dart → dart_format
      #     # JSON
      #     nodePackages.fixjson
      #     # Go → gofmt
      #     # Rust
      #     rustfmt
      #     # Shell
      #     shfmt
      #     # TOML
      #     taplo
      #     # HTML
      #     rubyPackages.htmlbeautifier
      #     # YAML
      #     yamlfmt
      #     # Python
      #     yapf
      #     # Fennel
      #     fnlfmt
      #     # Java
      #     google-java-format
      #     # Nix
      #     nixfmt
      #     # TypeScript
      #     # WIP
      #   ];
      #   onCommands = [ "Format" ];
      # }
      {
        # An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
        plugin = nvim-lint;
        postConfig = {
          language = "lua";
          code = readFile ./lua/lint.lua;
        };
        extraPackages = with pkgs; [ typos checkstyle ];
      }
      {
        # Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
        plugin = copilot-lua;
        postConfig = {
          language = "lua";
          code = readFile ./lua/copilot.lua;
        };
        extraPackages = with pkgs; [ nodejs ];
      }
      {
        plugin = reactive-nvim;
        # plugin = pkgs.vimPluginsUnstable.reactive-nvim.overrideAttrs (drv: {
        #   version = "patched";
        #   postInstall = ''
        #     mkdir -p $out/lua/reactive/presets
        #     ln -s ${./lua/reactive_kanagawa.lua} $out/lua/reactive/presets/kanagawa.lua
        #   '';
        # });
        postConfig = {
          language = "lua";
          code = readFile ./lua/reactive.lua;
        };
      }
      {
        # Add/change/delete surrounding delimiter pairs with ease.
        plugin = nvim-surround;
        postConfig = {
          language = "lua";
          code = readFile ./lua/surround.lua;
        };
      }
    ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/editHook.lua;
    };
    onEvents = [ "InsertEnter" "CursorMoved" ];
  };
  myTig = {
    name = "myTig";
    postConfig = {
      language = "lua";
      code = readFile ./lua/my-tig.lua;
    };
    # onCommands = [ "TigTermToggle" ];
  };
  oil = {
    name = "oil";
    plugins = [
      {
        plugin = oil-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/oil.lua;
        };
        dependPlugins = [ nvim-web-devicons ];
      }
      {
        plugin = oil-vcs-status;
        postConfig = {
          language = "lua";
          code = readFile ./lua/oil-vcs-status.lua;
        };
        # WIP
        # onCommands = [ "Oil" ];
        dependPlugins = [ oil-nvim ];
      }
    ];
    onModules = [ "oil" ];
    # onCommands = [ "Oil" ];
  };
  treesitter = {
    name = "treesitter";
    plugins = [
      nvim-treesitter
      # nvim-yati
      # {
      #   plugin = vim-matchup;
      #   preConfig = {
      #     language = "lua";
      #     code = readFile ./lua/vim-matchup-pre.lua;
      #   };
      # }
      # nvim-treesitter-textobjects
      # {
      #   plugin = rainbow-delimiters-nvim;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./lua/rainbow-delimiters.lua;
      #   };
      # }
    ];
    postConfig = let
      parser = pkgs.stdenv.mkDerivation {
        name = "treesitter-all-grammars";
        buildCommand = ''
          mkdir -p $out/parser
          echo "${
            concatStringsSep "," nvim-treesitter.withAllGrammars.dependencies
          }" \
            | tr ',' '\n' \
            | xargs -I {} find {} -not -type d \
            | xargs -I {} ln -s {} $out/parser
        '';
      };
    in {
      language = "lua";
      code = readFile ./lua/treesitter.lua;
      args = { inherit parser; };
    };
    # extraPackages = with pkgs; [ tree-sitter ];
    useTimer = true;
  };
  telescope = {
    name = "telescope";
    plugins = [
      {
        plugin = telescope-nvim;
        onModules = [ "telescope.themes" ];
      }
      telescope-fzf-native-nvim
      {
        plugin = telescope-live-grep-args-nvim;
        extraPackages = with pkgs; [ ripgrep ];
      }
      {
        plugin = telescope-sonictemplate-nvim;
        dependPlugins = [{
          plugin = vim-sonictemplate.overrideAttrs (old: {
            src = pkgs.nix-filter {
              root = vim-sonictemplate.src;
              exclude = [ "template/java" "template/make" ];
            };
          });
          preConfig = {
            language = "lua";
            code = ''
              vim.g.sonictemplate_vim_template_dir = "${pkgs.sonicCustomTemplates}"
              vim.g.sonictemplate_key = 0
              vim.g.sonictemplate_intelligent_key = 0
              vim.g.sonictemplate_postfix_key = 0
            '';
          };
        }];
      }
    ];
    dependPlugins = [ plenary-nvim skkeleton ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/telescope.lua;
    };
    onCommands = [ "Telescope" ];
  };
  lsp = {
    name = "lsp";
    plugins = [
      # {
      #   plugin = hover-nvim;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./lua/hover.lua;
      #   };
      # }
      {
        plugin = garbage-day-nvim;
        preConfig = {
          language = "lua";
          code = readFile ./lua/garbage-day-pre.lua;
        };
        postConfig = {
          language = "lua";
          code = readFile ./lua/garbage-day.lua;
        };
      }
      {
        plugin = nvim-lspconfig;
        # [WIP] dotnet
        # dotnet tool install --global csharp-ls
        extraPackages = (with pkgs; [
          # fennel-language-server
          dart
          deno
          dhall-lsp-server
          fennel-ls
          flutter
          google-java-format
          lua-language-server
          nil
          nodePackages.bash-language-server
          nodePackages.pyright
          nodePackages.typescript
          nodePackages.vscode-langservers-extracted
          nodePackages.yaml-language-server
          rubyPackages.solargraph
          rust-analyzer
          taplo-cli
          # efm
          efm-langserver
          stylua
          luajitPackages.luacheck
          fnlfmt
          nodePackages.prettier
          nodePackages.eslint
          nodePackages.fixjson
          shfmt
          taplo
          yamllint
          statix
          nixfmt
          google-java-format
          stylelint
          vim-vint
          yapf
          pylint
          gofumpt
          gotools
          shellcheck
          rustfmt
          gitlint
          hadolint
        ]) ++ (with pkgs.pkgs-unstable; [ nixd marksman ]);
        preConfig = {
          language = "lua";
          code = ''
            local ok, wf = pcall(require, "vim.lsp._watchfiles")
            if ok then
               -- disable lsp watcher. Too slow on linux
               wf._watchfunc = function()
                 return function() end
               end
            end
          '';
        };
        postConfig = {
          language = "lua";
          code = readFile ./lua/lspconfig.lua;
          args = {
            on_attach_path = ./lua/on_attach.lua;
            capabilities_path = ./lua/capabilities.lua;
          };
        };
        dependPlugins = [ climbdir-nvim efmls-configs-nvim ];
        useTimer = true;
      }
      {
        plugin = lsp-lens-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/lsp-lens.lua;
        };
      }
      {
        plugin = lsp-inlayhints-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/inlayhints.lua;
        };
      }
      # {
      #   # カーソルの対応する要素のハイライト.
      #   plugin = vim-illuminate;
      #  postConfig = readFile ./../../../nvim/illuminate.lua;
      # }
      # {
      #   plugin = hover-nvim;
      #  postConfig = readFile ./../../../nvim/hover.lua;
      # }
      # {
      #   plugin = pretty_hover;
      #  postConfig = readFile ./../../../nvim/pretty-hover.lua;
      # }
      {
        plugin = diagflow-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/diagflow.lua;
        };
      }
      # noice-nvim
      # {
      #   plugin = suit-nvim;
      #  postConfig = readFile ./../../../nvim/lua/suit.lua;
      # }
      {
        plugin = dressing-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/dressing.lua;
        };
        dependGroups = [ "telescope" ];
      }
    ];
    dependPlugins = [
      # {
      #   plugin = fidget-nvim;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./lua/fidget.lua;
      #   };
      # }
    ];
    dependGroups = [ "ddc" "telescope" ];
    useTimer = true;
  };
  neotest = {
    name = "neotest-bundle";
    plugins = [
      {
        plugin = neotest;
        dependPlugins = [ plenary-nvim nvim-nio ];
        dependGroups = [ "treesitter" "lsp" "dap" ];
      }
      neotest-java
      neotest-python
      neotest-plenary
      neotest-go
      neotest-jest
      neotest-vitest
      neotest-playwright
      neotest-rspec
      neotest-minitest
      neotest-dart
      neotest-testthat
      neotest-phpunit
      neotest-pest
      neotest-rust
      neotest-elixir
      neotest-dotnet
      neotest-scala
      neotest-haskell
      neotest-deno
      {
        plugin = neotest-vim-test;
        dependPlugins = [ vim-test ];
      }
      overseer-nvim
    ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/neotest.lua;
    };
    onCommands = [ "Neotest" ];
  };
  ddc = {
    name = "ddc";
    plugins = [
      {
        plugin = ddc-vim;
        useDenops = true;
      }
      {
        plugin = ddc-ui-pum;
        dependPlugins = [{
          plugin = pum-vim;
          dependPlugins = [
            {
              plugin = nvim-autopairs;
              dependGroups = [ "treesitter" ];
              postConfig = {
                language = "lua";
                code = readFile ./lua/autopairs.lua;
              };
              onEvents = [ "InsertEnter" ];
              onModules = [ "nvim-autopairs" ];
            }
          ];
          postConfig = {
            language = "vim";
            code = readFile ./vim/pum.vim;
          };
        }];
        useDenops = true;
      }
      {
        plugin = ddc-buffer;
        useDenops = true;
      }
      {
        plugin = ddc-converter_remove_overlap;
        useDenops = true;
      }
      {
        plugin = ddc-converter_truncate;
        useDenops = true;
      }
      {
        plugin = ddc-fuzzy;
        useDenops = true;
      }
      {
        plugin = ddc-matcher_head;
        useDenops = true;
      }
      {
        plugin = ddc-matcher_length;
        useDenops = true;
      }
      {
        plugin = ddc-sorter_itemsize;
        useDenops = true;
      }
      {
        plugin = ddc-sorter_rank;
        useDenops = true;
      }
      {
        plugin = ddc-source-around;
        useDenops = true;
      }
      {
        plugin = ddc-source-cmdline;
        useDenops = true;
      }
      {
        plugin = ddc-source-cmdline-history;
        useDenops = true;
      }
      {
        plugin = ddc-source-file;
        useDenops = true;
      }
      {
        plugin = ddc-source-input;
        useDenops = true;
      }
      {
        plugin = ddc-source-line;
        useDenops = true;
      }
      {
        plugin = ddc-sorter_reverse;
        useDenops = true;
      }
      {
        plugin = ddc-source-vsnip;
        dependPlugins = [{
          plugin = vim-vsnip;
          dependPlugins = [ tabout-nvim friendly-snippets ];
          postConfig = {
            language = "vim";
            code = readFile ./vim/vsnip.vim;
          };
        }];
        useDenops = true;
      }
      {
        plugin = ddc-source-lsp;
        onModules = [ "ddc_source_lsp" ];
        useDenops = true;
      }
      {
        plugin = ddc-source-lsp-setup;
        postConfig = {
          language = "lua";
          code = readFile ./lua/ddc-source-lsp-setup.lua;
        };
        dependPlugins = [ nvim-lspconfig ];
        useDenops = true;
      }
      # ddc-ui-native
      # denops-popup-preview-vim
      # {
      #   plugin = ddc-previewer-floating;
      #   postConfig = readFile ./../../../nvim/ddc-previewer-floating.lua;
      #   dependPlugins = [ pum-vim ];
      # }
      # {
      #   plugin = denops-signature_help;
      #   useDenops = true;
      # }
      {
        plugin = neco-vim;
        useDenops = true;
      }
      # TODO lazy
      # {
      #   plugin = ddc-source-nvim-obsidian;
      #   dependPlugins = [ obsidian-nvim ];
      #   useDenops = true;
      # }
      # {
      #   plugin = tsnip-nvim;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./lua/tsnip.lua;
      #     args = { tsnip_root = ./snip/tsnip; };
      #   };
      #   dependPlugins = [ nui-nvim ];
      #   useDenops = true;
      # }
    ];
    dependPlugins = [
      denops-vim
      # {
      #   plugin = LuaSnip;
      #   postConfig = {
      #     language = "lua";
      #     code = readFile ./../../../nvim/luasnip.lua;
      #     args = { snipmate_root = ./../../../snippets/snipmate; };
      #   };
      #   dependPlugins = [ friendly-snippets ];
      # }
    ];
    dependGroups = [ "lsp" "ddu" ];
    postConfig = {
      language = "vim";
      code = readFile ./vim/ddc.vim;
      args = { ts_config = ./denops/ddc.ts; };
    };
    onEvents = [ "InsertEnter" "CmdlineEnter" ];
  };
  ddu = {
    name = "ddu";
    plugins = [
      {
        plugin = ddu-vim;
        useDenops = true;
      }
      # ui
      {
        plugin = ddu-ui-ff;
        useDenops = true;
      }
      {
        plugin = ddu-ui-filer;
        useDenops = true;
      }
      # source
      {
        plugin = ddu-source-file;
        useDenops = true;
      }
      {
        plugin = ddu-source-file_rec;
        useDenops = true;
      }
      {
        plugin = ddu-source-rg;
        preConfig = {
          language = "vim";
          code = ''
            let g:loaded_ddu_rg = 1
          '';
        };
        useDenops = true;
        extraPackages = with pkgs; [ ripgrep ];
      }
      {
        plugin = ddu-source-ghq;
        useDenops = true;
        extraPackages = with pkgs; [ ghq ];
      }
      {
        plugin = ddu-source-file_external;
        useDenops = true;
        extraPackages = with pkgs; [ fd ];
      }
      {
        plugin = ddu-source-mr;
        useDenops = true;
        dependPlugins = [ mr-vim ];
      }
      # filter
      {
        plugin = ddu-filter-fzf;
        useDenops = true;
        extraPackages = with pkgs; [ fzf ];
      }
      {
        plugin = ddu-filter-matcher_files;
        useDenops = true;
      }
      # filter (matcher)
      {
        plugin = ddu-filter-matcher_substring;
        useDenops = true;
      }
      {
        plugin = ddu-filter-matcher_hidden;
        useDenops = true;
      }
      # filter (sorter)
      {
        plugin = ddu-filter-sorter_alpha;
        useDenops = true;
      }
      # filter (converter)
      {
        plugin = ddu-filter-converter_hl_dir;
        useDenops = true;
      }
      # {
      #   plugin = ddu-filter-converter_devicon;
      #   useDenops = true;
      # }
      {
        plugin = ddu-filter-converter_display_word;
        useDenops = true;
      }
      # kind
      {
        plugin = ddu-kind-file;
        useDenops = true;
      }
      # other
      {
        plugin = ddu-commands-vim;
        useDenops = true;
      }
      # {
      #   plugin = kensaku-vim;
      #   useDenops = true;
      # }
      # {
      #   plugin = ddu-vim-ui-select;
      #   useDenops = true;
      # }
    ];
    dependPlugins = [ denops-vim ];
    postConfig = {
      language = "vim";
      code = readFile ./vim/ddu.vim;
      args = { ts_config = ./denops/ddu.ts; };
    };
    onCommands = [ "Ddu" "DduRg" "DduRgLive" ];
    useTimer = true;
  };
  dap = {
    name = "dap";
    plugins = [
      nvim-dap
      {
        plugin = nvim-dap-ui;
        dependPlugins = [ nvim-nio ];
      }
      nvim-dap-virtual-text
      nvim-dap-repl-highlights
      nvim-dap-go
      overseer-nvim
    ];
    dependPlugins = [ stickybuf-nvim ];
    dependGroups = [ "treesitter" ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/dap.lua;
    };
    useTimer = true;
  };
}
