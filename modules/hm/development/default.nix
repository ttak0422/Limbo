_: {
  flake.nixosModules.hm-development = { ... }: {
    imports = [
      ./node
      ./deno.nix
      ./dhall.nix
      ./dotnet.nix
      ./elm.nix
      ./go.nix
      ./haskell.nix
      ./java.nix
      ./lua.nix
      ./nix.nix
      ./python.nix
      ./rust.nix
      ./scala.nix
    ];
  };
}
