_: {
  flake.nixosModules.nixos-prelude = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      promptInit = "";
    };
  };
}
