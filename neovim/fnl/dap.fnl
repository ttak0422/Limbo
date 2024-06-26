(let [;; modules
      dap (require :dap)
      dap-vscode (require :dap.ext.vscode)
      dap-ui (require :dapui)
      dap-virt (require :nvim-dap-virtual-text)
      dap-hl (require :nvim-dap-repl-highlights)
      ; kanagawa (require :kanagawa.colors)
      ; kanagawa_palette (. ((. kanagawa :setup)) :palette) ;;
      morimo_colors (require :morimo.colors) ;; ui
      icons {:expanded "▾" :collapsed "▸" :current_frame "▸"}
      controls {:element :repl
                :enabled true
                :icons {:disconnect ""
                        :pause ""
                        :play ""
                        :run_last ""
                        :step_back ""
                        :step_into ""
                        :step_out ""
                        :step_over ""
                        :terminate ""}}
      floating {:border :none :mappings {:close [:q :<Esc>]}}
      layouts [{:elements [{:id :scopes :size 0.25}
                           {:id :breakpoints :size 0.25}
                           {:id :stacks :size 0.25}
                           {:id :watches :size 0.25}]
                :position :left
                :size 40}
               {:elements [{:id :repl :size 0.5} {:id :console :size 0.5}]
                :position :bottom
                :size 10}]
      mappings {:edit :e
                :expand [:<CR> :<2-LeftMouse>]
                :open :o
                :remove :d
                :repl :r
                :toggle :t}
      render {:indent 1 :max_value_lines 100} ;;
      ;; virtual-text
      display_callback (fn [variable _buf _stackframe _node options]
                         (if (= options.virt_text_pos :inline)
                             (.. " = " variable.value)
                             (.. variable.name " = " variable.value)))
      virt_text_pos ((fn []
                       (if (= (vim.fn.has :nvim-0.10) 1) :inline :eol)))
      ;; other
      highlights [; [:dapblue kanagawa_palette.crystalBlue]
                  ; [:dapgreen kanagawa_palette.springGreen]
                  ; [:dapyellow kanagawa_palette.carpYellow]
                  ; [:daporange kanagawa_palette.surimiOrange]
                  ; [:dapred kanagawa_palette.peachRed]
                  [:dapblue morimo_colors.lightBlue]
                  [:dapgreen morimo_colors.lightGreen]
                  [:dapyellow morimo_colors.lightYellow]
                  [:daporange morimo_colors.orange]
                  [:dapred morimo_colors.lightRed]]
      signs [[:DapBreakpoint "" :dapblue]
             [:DapBreakpointCondition "" :dapblue]
             [:DapBreakpointRejected "" :dapred]
             [:DapStopped "▶" :dapgreen]
             [:DapLogPoint "" :dapyellow]]]
  ;; dap
  (tset dap.listeners.before.event_terminated :dapui_config (fn []))
  (tset dap.listeners.before.event_exited :dapui_config (fn []))
  ;; dap-vscode
  (dap-vscode.load_launchjs)
  ;; dapui
  (dap-ui.setup {:element_mappings []
                 :expand_lines true
                 :force_buffers true
                 : icons
                 : controls
                 : floating
                 : layouts
                 : mappings
                 : render})
  ;; dap-virtual-text
  (dap-virt.setup {:enabled false
                   :enabled_commands true
                   :highlight_changed_variables true
                   :highlight_new_as_changed false
                   :show_stop_reason true
                   :commented true
                   :only_first_definition true
                   :all_references false
                   :clear_on_continue false
                   : display_callback
                   : virt_text_pos
                   :all_frames false
                   :virt_lines false
                   :virt_text_win_col nil})
  ;; highlights
  (dap-hl.setup {})
  ;; other
  ;; signの背景色を削除
  (each [_ h (ipairs highlights)]
    (vim.api.nvim_set_hl 0 (. h 1) {:fg (. h 2) :bg :none}))
  (each [_ s (ipairs signs)]
    (vim.fn.sign_define (. s 1) {:text (. s 2)
                                 :texthl (. s 3)
                                 :linehl ""
                                 :numhl ""})))
