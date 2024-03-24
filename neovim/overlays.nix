inputs:
with inputs; [
  (final: prev: { neovim-v9 = prev.neovim-unwrapped; })
  vim-plugins-overlay.overlay
  neovim-nightly-overlay.overlay
  nix-filter.overlays.default
  (final: prev:
    let
      inherit (prev.stdenv) mkDerivation isDarwin;
      inherit (prev.stdenv) system;
    in {
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      neovim-nightly-latest =
        neovim-nightly-overlay-latest.packages.${prev.system}.neovim;
      vimPluginsUnstable = vim-plugins-overlay-unstable.packages.${prev.system}
        // {
          # lir-nvim = prev.vimUtils.buildVimPlugin {
          #   pname = "lir-nvim";
          #   version = "unstable";
          #   src = inputs.lir-nvim;
          # };
        };
      vimPlugins = prev.vimPlugins // {
        vim-sonictemplate = prev.vimUtils.buildVimPlugin {
          pname = "vim-sonictemplate";
          version = "unstable";
          src = inputs.vim-sonictemplate;
        };
        tshjkl-nvim = prev.vimUtils.buildVimPlugin {
          pname = "tshjkl-nvim";
          version = "unstable";
          src = inputs.tshjkl-nvim;
        };
        statuscol-nvim = prev.vimUtils.buildVimPlugin {
          pname = "statuscol-nvim";
          version = "unstable";
          src = inputs.statuscol-nvim;
        };
        telescope-fzf-native-nvim =
          prev.vimPlugins.telescope-fzf-native-nvim.overrideAttrs {
            dependencies = [ ];
          };
        nvim-jdtls = prev.vimUtils.buildVimPlugin {
          pname = "nvim-jdtls";
          version = "unstable";
          src = inputs.nvim-jdtls;
        };
        tsnip-nvim = prev.vimUtils.buildVimPlugin {
          pname = "tsnip-nvim";
          version = "unstable";
          src = inputs.tsnip-nvim-src;
        };
        LuaSnip = prev.vimUtils.buildVimPlugin {
          pname = "LuaSnip";
          version = "unstable";
          src = prev.vimPlugins.LuaSnip;
          nativeBuildInputs = [ prev.gcc ];
          buildPhase = ''
            ${if isDarwin then
              "LUA_LDLIBS='-undefined dynamic_lookup -all_load'"
            else
              ""}
            JSREGEXP_PATH=deps/jsregexp
            make "INCLUDE_DIR=-I $PWD/deps/lua51_include" LDLIBS="$LUA_LDLIBS" -C $JSREGEXP_PATH
            cp $JSREGEXP_PATH/jsregexp.so lua/luasnip-jsregexp.so
          '';
        };
      };
      javaPackages = prev.javaPackages // { inherit (inputs) jol; };
      python3Packages = prev.python3Packages
        // (with prev.python3Packages; rec {
          wrapt = buildPythonPackage rec {
            pname = "wrapt";
            version = "1.15.0";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-0Gcwxq7XjO5BJiNM8tBx4BtEuRXnJabLQ5qHnsl1Sjo=";
            };
            doCheck = false;
          };
          Deprecated = buildPythonPackage rec {
            pname = "Deprecated";
            version = "1.2.14";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-5TI+uTZFjczCWC3G+cMiyFKndaJwZf8rDElwudU9AbM=";
            };
            doCheck = false;
            propagatedBuildInputs = [ wrapt ];
          };
          jaconv = buildPythonPackage rec {
            pname = "jaconv";
            version = "0.3.4";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-nnxV8/Cw4tutYvbJ+gww/G//27eCl5VVCdkIVrOjHW0=";
            };
            doCheck = false;
          };
          pykakasi = buildPythonPackage rec {
            pname = "pykakasi";
            version = "2.2.1";
            src = prev.fetchPypi {
              inherit pname version;
              sha256 = "sha256-OjUQkppVlsrlH/+pz3jA90LZbOvZP3JslqzuUUB9GMw=";
            };
            doCheck = false;
            propagatedBuildInputs = [ Deprecated jaconv setuptools ];
          };
        });

      sonicCustomTemplates = mkDerivation {
        name = "sonic-custom-templates";
        src = ./snip/sonic;
        installPhase = ''
          mkdir $out
          cp -r ./* $out
        '';
      };

      # jdt-language-server =
      #   let
      #     version = "1.30.1";
      #     timestamp = "202312071447";
      #   in
      #   prev.jdt-language-server.overrideAttrs (old: {
      #     src = prev.fetchurl {
      #       url =
      #         "https://download.eclipse.org/jdtls/milestones/${version}/jdt-language-server-${version}-${timestamp}.tar.gz";
      #       sha256 =
      #         "4c005ede9df73e60cfb8f611373808c9121286d3adbfb745384cced9f19b2de3";
      #     };
      #   });
      fennel-ls = mkDerivation {
        name = "fennel-ls";
        src = inputs.fennel-ls-src;
        nativeBuildInputs = with prev; [ luajit buildPackages.makeWrapper ];
        buildPhase = ''
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          make install PREFIX=$out
        '';
      };
    })
]
