{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ zellij ];
    file.".config/zellij/config.kdl".text = builtins.readFile ./config.kdl;
    file.".config/zellij/layouts/default.kdl".text = ''
      layout {
          pane
          pane size=1 borderless=true {
              plugin location="zellij:compact-bar"
          }
      }
    '';
  };
}
