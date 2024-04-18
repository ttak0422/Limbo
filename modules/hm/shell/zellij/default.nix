{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ zellij ];
    file.".config/zellij/config.kdl".text = builtins.readFile ./config.kdl;
    file.".config/zellij/layouts/default.kdl".text = ''
      layout {
          default_tab_template {
              children
              pane size=1 borderless=true {
                  plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                      format_left   "{mode}"
                      format_center "{tabs}"
                      format_right  ""
                      format_space  "[fg=#1a1a22,bg=#1a1a22]"
                      first_start "true"

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#6C7086]{char}"
                      border_position "top"

                      hide_frame_for_single_pane "true"

                      mode_normal  "#[fg=#090618,bg=#7E9CD8,bold] {name} "
                      mode_locked  "#[fg=#090618,bg=#C34043,bold] {name} "
                      mode_tmux    "#[fg=#090618,bg=#ffc387,bold] {name} "

                      tab_normal   "#[fg=#6C7086,bg=#1a1a22] {name} "
                      tab_active   "#[fg=#9399B2,bg=#1a1a22,bold,italic] {name} "

                      command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                      command_git_branch_format      "#[fg=blue] {stdout} "
                      command_git_branch_interval    "10000"
                      command_git_branch_rendermode  "static"

                      datetime        "#[fg=#6C7086,bold] {format} "
                      datetime_format "%A, %d %b %Y %H:%M"
                      datetime_timezone "Europe/Berlin"
                  }
              }
          }
      }
    '';
  };
}
