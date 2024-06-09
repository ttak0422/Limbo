{ self, withSystem, inputs, ... }:
let
  inherit (builtins) attrValues;
  inherit (self.lib) mkConfiguration mkHmModule;
  hmStateVersion = "24.05";
  username = "ttak0422";
  userEmail = "ttak0422@gmail.com";
  flags = { foo = "bar"; };
in {
  flake.nixosConfigurations = withSystem "x86_64-linux"
    ({ self', inputs', system, pkgs, ... }: {
      wsl = mkConfiguration {
        inherit system pkgs flags;
        specialArgs = { inherit inputs username; };
        modules = [
          inputs.nixos-wsl.nixosModules.wsl
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          inputs.nixpkgs.nixosModules.notDetected
          inputs.home-manager.nixosModules.home-manager
          self.nixosModules.shared-prelude
          self.nixosModules.nixos-prelude
          self.nixosModules.nixos-service
          {
            nixpkgs = {
              overlays = attrValues self.overlays;
              config = {
                allowUnfree = true;
                permittedInsecurePackages = [ ];
              };
            };
            wsl = {
              enable = true;
              defaultUser = "${username}";
              startMenuLaunchers = true;
            };
            system.stateVersion = hmStateVersion;
            users.defaultUserShell = pkgs.zsh;
            users.users."${username}" = {
              isNormalUser = true;
              group = "users";
              extraGroups = [ "wheel" ];
              createHome = false;
              home = "/home/${username}";
            };
            environment.systemPackages = [
              (pkgs.runCommand "nvim" { } ''
                mkdir -p $out/bin
                ln -s ${self'.packages.bundler-nvim-stable}/bin/nvim $out/bin/nvim
              '')
            ];
            boot.tmp.cleanOnBoot = true;
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
