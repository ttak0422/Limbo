{ pkgs, ... }: {
  home.packages = with pkgs.elmPackages;
    [
      # WIP: for darwin
      # elm elm-test
    ];
}
