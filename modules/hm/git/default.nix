_: {
  flake.nixosModules.hm-git = { ... }: {
    imports = [ ./git.nix ./tig.nix ];
  };
}
