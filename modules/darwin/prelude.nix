_: {
  flake.nixosModules.darwin-prelude = { pkgs, ... }: {
    services.nix-daemon.enable = true;
    programs.zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
