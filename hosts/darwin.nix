{ self, withSystem, inputs, ... }:
let
  inherit (builtins) attrValues;
  inherit (self.lib) mkConfiguration mkHmModule;
  hmStateVersion = "23.11";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";
  flags = { foo = "bar"; };
in {
  flake.darwinConfigurations = withSystem "aarch64-darwin"
    ({ self', inputs', system, pkgs, ... }: {
      darwin = mkConfiguration {
        inherit system pkgs flags;
        specialArgs = { inherit inputs username; };
        modules = [
          inputs.home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
          self.nixosModules.shared-prelude
          self.nixosModules.darwin-prelude
          self.nixosModules.darwin-homebrew
          self.nixosModules.darwin-desktop
          {
            nixpkgs = {
              overlays = attrValues self.overlays;
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [ ];
              };
            };
            users.users.${username}.home = "/Users/${username}";
            environment.systemPackages = [
              (pkgs.runCommand "nvim" { } ''
                mkdir -p $out/bin
                ln -s ${self'.packages.bundler-nvim}/bin/nvim $out/bin/nvim
              '')
            ];
          }
          (mkHmModule {
            inherit pkgs username flags;
            stateVersion = hmStateVersion;
            extraSpecialArgs = { inherit inputs system username userEmail; };
            modules = [
              self.nixosModules.hm-app
              self.nixosModules.hm-development
              self.nixosModules.hm-git
              self.nixosModules.hm-shell
              self.nixosModules.hm-tools
            ];
          })
        ];
      };
    });
}
