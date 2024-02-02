{ pkgs, lib }:
let
  inherit (builtins) readFile;
  inherit (lib.strings) concatStringsSep;
in
with pkgs.vimPlugins; {
  treesitter = {
    name = "treesitter";
    plugins = [
      nvim-treesitter
      # WIP: nix parsers are broken
      # WIP: `bash` does not work on lazy loading
      # pkgs.pkgs-unstable.vimPlugins.nvim-treesitter
      # (pkgs.pkgs-unstable.vimPlugins.nvim-treesitter.withPlugins
      #   (p: with p; [ bash ]))
      nvim-yati
      {
        plugin = vim-matchup;
        preConfig = {
          language = "lua";
          code = readFile ./lua/vim-matchup-pre.lua;
        };
      }
      nvim-treesitter-textobjects
      {
        plugin = rainbow-delimiters-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/rainbow-delimiters.lua;
        };
      }
    ];
    postConfig =
      let
        parser = pkgs.stdenv.mkDerivation {
          name = "treesitter-all-grammars";
          buildCommand = ''
            mkdir -p $out/parser
            echo "${
              concatStringsSep ","
              pkgs.pkgs-unstable.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
            }" \
              | tr ',' '\n' \
              | xargs -I {} find {} -not -type d \
              | xargs -I {} ln -s {} $out/parser
          '';
        };
      in
      {
        language = "lua";
        # code = ''
        #   vim.opt.runtimepath:append("${parser}");
        # '' +
        code = readFile ./lua/treesitter.lua;
        args = { inherit parser; };
      };
    extraPackages = [ pkgs.pkgs-unstable.tree-sitter ];
    useTimer = true;
  };
  skk = {
    name = "skk";
    plugins = [{
      plugin = skkeleton;
      useDenops = true;
    }
      # wip
      # {
      #   plugin = skk-vconv-vim;
      #   dependPlugins = [ skkeleton ];
      #   extraPackages = with pkgs; [ python3Packages.pykakasi ];
      # }
      # {
      #   plugin = skkeleton_indicator-nvim;
      #   postConfig = readFile ./../../nvim/skk-indicator.lua;
      # }
    ];
    dependPlugins = [ denops-vim ];
    dependGroups = [ "ddc" ];
    postConfig = {
      language = "vim";
      code = readFile ./vim/skk.vim;
      args = { dicts = [ "${pkgs.skk-dicts}/share/SKK-JISYO.L" ]; };
    };
    onEvents = [ "InsertEnter" "CmdlineEnter" ];
  };
  telescope = {
    name = "telescope";
    plugins = [
      telescope-nvim
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
    dependPlugins = [ plenary-nvim ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/telescope.lua;
    };
    onCommands = [ "Telescope" ];
  };
  lsp = {
    name = "lsp";
    plugins = [
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
          dart
          deno
          dhall-lsp-server
          google-java-format
          gopls
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
          # fennel-language-server
          fennel-ls
        ]) ++ (with pkgs.pkgs-unstable; [ nixd marksman ]);
        postConfig = {
          language = "lua";
          code = readFile ./lua/lspconfig.lua;
          args = {
            on_attach_path = ./lua/on_attach.lua;
            capabilities_path = ./lua/capabilities.lua;
          };
        };
        dependPlugins = [ climbdir-nvim ];
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
      # {
      #   plugin = diagflow-nvim;
      #  postConfig = readFile ./../../../nvim/diagflow.lua;
      # }
      noice-nvim
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
    dependPlugins = [{
      plugin = fidget-nvim;
      postConfig = {
        language = "lua";
        code = readFile ./lua/fidget.lua;
      };
    }];
    dependGroups = [ "ddc" ];
    useTimer = true;
  };
  neotest = {
    name = "neotest-bundle";
    plugins = [
      {
        plugin = neotest;
        dependPlugins = [ plenary-nvim ];
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
            noice-nvim
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
          dependPlugins = [ tabout-nvim ];
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
        useDenops = true;
      }
      {
        plugin = ddc-tmux;
        useDenops = true;
      }
      # ddc-ui-native
      # denops-popup-preview-vim
      # {
      #   plugin = ddc-previewer-floating;
      #   postConfig = readFile ./../../../nvim/ddc-previewer-floating.lua;
      #   dependPlugins = [ pum-vim ];
      # }
      {
        plugin = denops-signature_help;
        useDenops = true;
      }
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
      {
        plugin = tsnip-nvim;
        postConfig = {
          language = "lua";
          code = readFile ./lua/tsnip.lua;
          args = { tsnip_root = ./snip/tsnip; };
        };
        dependPlugins = [ nui-nvim ];
        useDenops = true;
      }
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
      {
        plugin = ddu-filter-converter_devicon;
        useDenops = true;
      }
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
      {
        plugin = kensaku-vim;
        useDenops = true;
      }
      # {
      #   plugin = ddu-vim-ui-select;
      #   useDenops = true;
      # }
    ];
    dependPlugins = [ denops-vim qf-nvim nvim-bqf ];
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
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-dap-repl-highlights
      nvim-dap-go
      overseer-nvim
    ];
    dependGroups = [ "treesitter" ];
    postConfig = {
      language = "lua";
      code = readFile ./lua/dap.lua;
    };
    useTimer = true;
  };
}
