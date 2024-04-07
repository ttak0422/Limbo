_: {
  flake.nixosModules.hm-app = { ... }: {
    imports = [ ./alacritty ./wezterm ];
  };
}
