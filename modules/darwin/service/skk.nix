{ inputs, ... }: {
  flake.nixosModules.darwin-service = { pkgs, ... }: {
    imports = [ inputs.yaskkserv2-service.darwinModules.default ];
    services.yaskkserv2 = {
      enable = true;
      # 要手動生成
      dictionary = "/tmp/dictionary.yaskkserv2";
    };
  };
}
