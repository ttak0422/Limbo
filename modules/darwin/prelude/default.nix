_: {
  flake.nixosModules.darwin-prelude = { pkgs, ... }: {
    imports = [
      ./dock.nix
      ./finder.nix
      ./keyboard.nix
      ./loginwindow.nix
      ./ng-global.nix
    ];
    services.nix-daemon.enable = true;
    programs.zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
