{ pkgs, ... }: {
  home.packages = with pkgs; [ dhall dhall-nix dhall-json dhall-docs ];
}
