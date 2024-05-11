{ inputs, lib, ... }: {
  flake.overlays = {
    fromInputs = lib.composeManyExtensions [
      (final: prev:
        let inherit (prev.stdenv) system;
        in {
          pkgs-x86_64-darwin = import inputs.nixpkgs {
            system = "x86_64-darwin";
            config.allowUnfree = true;
          };
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          zjstatus = inputs.zjstatus.packages.${prev.system}.default;
        })
    ];
  };
}
