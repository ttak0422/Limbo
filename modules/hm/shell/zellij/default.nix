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
                      format_right  "[fg=#76946A,bg=#2a2a2e]"
                      format_space  "[fg=#b5d2a9,bg=#2a2a2e]"
                      first_start "true"

                      border_enabled  "false"
                      border_char     "─"
                      border_format   "#[fg=#6C7086]{char}"
                      border_position "top"

                      hide_frame_for_single_pane "true"

                      mode_tmux          "#[fg=#d3c785,bg=#2a2a2e,bold,italic]-- Zellij --"
                      mode_normal        "#[fg=#767b82,bg=#2a2a2e,bold]-- Zellij --"
                      mode_scroll        "#[fg=#767b82,bg=#2a2a2e,bold]-- {name} --"
                      mode_enter_search  "#[fg=#767b82,bg=#2a2a2e,bold]-- {name} --"
                      mode_search        "#[fg=#767b82,bg=#2a2a2e,bold]-- {name} --"

                      tab_normal   "#[fg=#767b82,bg=#2a2a2e] {name} "
                      tab_active   "#[fg=#d99872,bg=#2a2a2e,bold,italic] {name} "

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
