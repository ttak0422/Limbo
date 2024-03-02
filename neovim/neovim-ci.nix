{ pkgs, ... }:
{
  ci-nightly-latest = {
    package = pkgs.neovim-nightly-latest;
  };
}
