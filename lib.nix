{ inputs, ... }: {
  flake.lib = let
    inherit (inputs.darwin.lib) darwinSystem;
    inherit (inputs.nixpkgs.lib) nixosSystem;
  in {
    mkHmModule = { pkgs, username, stateVersion, modules ? [ ]
      , extraSpecialArgs ? { }, sharedModules ? [ ], flags ? { } }: {
        home-manager = {
          inherit sharedModules;
          useUserPackages = true;
          useGlobalPkgs = true;
          users.${username} = {
            imports = modules;
            home = { inherit username stateVersion; };
          };
          extraSpecialArgs = extraSpecialArgs // { inherit flags; };
        };
      };

    mkConfiguration = { system, pkgs, modules, specialArgs ? { }, flags ? { } }:
      let inherit (pkgs.stdenv) isDarwin;
      in (if isDarwin then darwinSystem else nixosSystem) {
        inherit system modules;
        specialArgs = specialArgs // { inherit flags; };
      };
  };
}
