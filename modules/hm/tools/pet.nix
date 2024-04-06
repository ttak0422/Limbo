{ pkgs, lib, ... }:
let
  inherit (lib.strings) concatStringsSep concatMapStringsSep;
  makeSnippet = { description, command, tag ? [ ], output ? "" }: ''
    [[snippets]]
        description = "${description}"
        command = "${command}"
        tag = [${concatStringsSep ", " (map (x: ''"${x}"'') tag)}]
        output = "${output}"
  '';
  snippets = concatMapStringsSep "\n" makeSnippet [
    {
      description = "ping";
      command = "ping 8.8.8.8";
      tag = [ "network" "google" ];
      output = "sample snippet";
    }
    {
      description = "rust repl";
      tag = [ "rust" ];
      command = "${pkgs.evcxr}/bin/evcxr";
    }
    {
      description = "derivate regex pattern from example";
      tag = [ "regex" ];
      command = "${pkgs.grex}/bin/grex -c '<example>'";
    }
  ];
in {
  home = {
    packages = [ pkgs.pet ];
    file.".config/pet/config.toml".text = ''
      [General]
          snippetfile = "$HOME/.config/pet/snippets.toml"
          editor = "nvim"
          column = 40
          selectcmd = "${pkgs.fzf}/bin/fzf"
    '';
    file.".config/pet/snippets.toml".text = snippets;
  };
}
