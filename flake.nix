{
  description = "dotfiles v4";

  inputs = {
    morimo = {
      # url = "path:/Users/ttak0422/ghq/github.com/ttak0422/morimo";
      url = "github:ttak0422/morimo";
      flake = false;
    };
    vim-sonictemplate = {
      url =
        "github:ttak0422/vim-sonictemplate/feature/support-java-test-directory";
      flake = false;
    };
    statuscol-nvim = {
      url = "github:luukvbaal/statuscol.nvim/0.10";
      flake = false;
    };
    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    nix-filter.url = "github:numtide/nix-filter";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "nixos-hardware";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix-darwin.follows = "darwin";
        flake-utils.follows = "flake-utils";
      };
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask-fonts = {
      url = "github:Homebrew/homebrew-cask-fonts";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay = {
      url = "github:ttak0422/neovim-treesitter-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "path:/Users/ttak0422/ghq/github.com/ttak0422/neovim-treesitter-overlay";
    nvim-jdtls = {
      url =
        "github:mfussenegger/nvim-jdtls?rev=66b5ace68a5d1c45fdfb1afa8d847e87af2aa1f8";
      flake = false;
    };
    loaded-nvim = {
      url = "github:ttak0422/loaded-nvim";
      inputs = {
        systems.follows = "systems";
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    vim-plugins-overlay = {
      url = "github:ttak0422/vim-plugins-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    vim-plugins-overlay-unstable = {
      url = "github:ttak0422/vim-plugins-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    bundler = {
      url = "github:ttak0422/bundler";
      # url = "path:/Users/ttak0422/ghq/github.com/ttak0422/bundler";
      # url = "path:/home/ttak0422/ghq/github.com/ttak0422/bundler";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    fennel-ls-src = {
      url = "sourcehut:~xerool/fennel-ls";
      flake = false;
    };
    tsnip-nvim-src = {
      url = "github:gamoutatsumi/tsnip.nvim/update-to-ddc-4";
      flake = false;
    };
    jol = {
      url =
        "https://repo.maven.apache.org/maven2/org/openjdk/jol/jol-cli/0.16/jol-cli-0.16-full.jar";
      flake = false;
    };
    junit-console = {
      url =
        "https://repo.maven.apache.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.2/junit-platform-console-standalone-1.10.2.jar";
      flake = false;
    };
    yaskkserv2-service = {
      url = "github:ttak0422/yaskkserv2-service";
      # url = "path:/Users/ttak0422/ghq/github.com/ttak0422/yaskkserv2-service";
      # url = "path:/home/ttak0422/ghq/github.com/ttak0422/yaskkserv2-service";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    skk-dev-dict = {
      url = "github:skk-dev/dict";
      flake = false;
    };
    # update automatic
    vim-plugins-overlay-latest = {
      url = "github:ttak0422/vim-plugins-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    neovim-nightly-overlay-latest.url =
      "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ ./lib.nix ./overlay.nix ./neovim ./modules ./hosts ];
      perSystem = { inputs, pkgs, ... }: {
        apps = {
          show-inputs = let
            drv = pkgs.writeShellApplication {
              name = "app";
              runtimeInputs = with pkgs; [ jq coreutils ];
              text = ''
                nix flake show --json \
                      | jq -r '.packages.["x86_64-linux"] | keys[]' \
                      | tr '\n' ' '
              '';
            };
          in {
            type = "app";
            program = "${drv}/bin/app";
          };
        };
      };
    };
}
