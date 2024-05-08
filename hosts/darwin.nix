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
          self.nixosModules.shared-prelude
          self.nixosModules.darwin-prelude
          self.nixosModules.darwin-homebrew
          self.nixosModules.darwin-desktop
          self.nixosModules.darwin-service
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
                ln -s ${self'.packages.bundler-nvim-stable}/bin/nvim $out/bin/nvim
              '')
              (pkgs.runCommand "gsed" { } ''
                mkdir -p $out/bin
                ln -s ${pkgs.gnused}/bin/sed $out/bin/gsed
              '')
              (pkgs.runCommand "ggrep" { } ''
                mkdir -p $out/bin
                ln -s ${pkgs.gnugrep}/bin/grep $out/bin/ggrep
              '')
            ];
          }
          (mkHmModule {
            inherit pkgs username flags;
            stateVersion = hmStateVersion;
            extraSpecialArgs = { inherit inputs system username userEmail; };
            modules = [
              self.nixosModules.hm-app
              self.nixosModules.hm-darwin
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
