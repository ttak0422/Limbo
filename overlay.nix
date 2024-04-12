{ inputs, lib, ... }: {
  flake.overlays = {
    fromInputs = lib.composeManyExtensions [
      (final: prev: {
        pkgs-x86_64-darwin = import inputs.nixpkgs {
          system = "x86_64-darwin";
          config.allowUnfree = true;
        };
        zjstatus = inputs.zjstatus.packages.${prev.system}.default;
      })
    ];
  };
}
