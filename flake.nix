{
  description = "dotfiles v4";

  inputs = {
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
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };
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
    # update automatic
    vim-plugins-overlay-latest = {
      url = "github:ttak0422/vim-plugins-overlay";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };
    neovim-nightly-overlay-latest = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
      };
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [ ./neovim ];
    };
}
