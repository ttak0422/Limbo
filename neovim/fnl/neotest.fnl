(let [neotest (require :neotest)
      adapters [((require :neotest-jest) {:jestConfigFile :jest.config.js
                                          :env {:CI true}
                                          :cwd (fn [] (vim.fn.getcwd))})
                ((require :neotest-vim-test) {:allow_file_types []})
                ((require :neotest-python) {:dap {:justMyCode false}})
                ((require :neotest-java) {:ignore_wrapper false
                                          :junit_jar args.junit_jar_path})
                (require :neotest-plenary)
                ; (require :neotest-go)
                ((require :neotest-golang) {:go_test_args [:-v
                                                           :-race
                                                           :-count=1
                                                           :-timeout=60s
                                                           (.. :-coverprofile=
                                                               (vim.fn.getcwd)
                                                               :/coverage.out)]})
                (require :neotest-vitest)
                (require :neotest-rspec)
                (require :neotest-minitest)
                ((require :neotest-dart) {:command :flutter
                                          :use_lsp true
                                          :custom_test_method_names {}})
                ((require :neotest-rust) {:args [:--no-capture]
                                          :dap_adapter :lldb})
                (require :neotest-elixir)
                (require :neotest-dotnet)
                (require :neotest-scala)
                (require :neotest-haskell)
                (require :neotest-deno)
                ((. (require :neotest-playwright) :adapter) {:options {:persist_project_selection true
                                                                       :enable_dynamic_test_discovery true
                                                                       :preset :none
                                                                       ;; "none" | "headed" | "debug"
                                                                       ;; get_playwright_binary  function()
                                                                       ;;    return vim.loop.cwd() + "/node_modules/.bin/playwright"
                                                                       ;; end
                                                                       ;; get_playwright_config  function()
                                                                       ;;    return vim.loop.cwd() + "/playwright.config.ts"
                                                                       ;; end
                                                                       :get_cwd (fn []
                                                                                  (vim.loop.cwd))
                                                                       :env {}
                                                                       :extra_args {}
                                                                       :filter_dir (fn [name
                                                                                        _rel_path
                                                                                        _root]
                                                                                     (not= name
                                                                                           :node_modules))}})]
      benchmark {:enabled true}
      consumers {:overseer (require :neotest.consumers.overseer)
                 :playwright (. (require :neotest-playwright.consumers)
                                :consumers)} ;;
      ;; `integrated` strategy without attach
      default_strategy (fn [spec]
                         (var result_code nil)
                         (let [nio (require :nio)
                               types (require :neotest.types)
                               handle_err (fn [e]
                                            (assert (not e) e))
                               path (nio.fn.tempname)
                               future (nio.control.future)
                               out (types.FanoutAccum (fn [prev new]
                                                        (if (not prev)
                                                            new
                                                            (.. prev new))))
                               cmd spec.command
                               ctx {:cwd spec.cwd
                                    :env spec.env
                                    :pty true
                                    :height spec.strategy.height
                                    :width spec.strategy.width
                                    :on_stdout (fn [_ d]
                                                 (out:push (table.concat d "\n")))
                                    :on_exit (fn [_ code]
                                               (set result_code code)
                                               (future.set))}
                               (open_err output_fd) (nio.uv.fs_open path :w 438)]
                           (handle_err open_err)
                           (out:subscribe (fn [data]
                                            (vim.loop.fs_write output_fd data
                                                               nil handle_err)))
                           (let [(success job) (pcall nio.fn.jobstart cmd ctx)]
                             (if (not success)
                                 (let [(write_err _) (nio.uv.fs_write output_fd
                                                                      job)]
                                   (handle_err write_err)
                                   (set result_code 1)
                                   (future.set)))
                             {:is_complete (fn [] (not= result_code nil))
                              :output (fn [] path)
                              :stop (fn [] (nio.fn.jobstop job))
                              :output_stream (fn []
                                               (let [queue (nio.control.queue)]
                                                 (out:subscribe (fn [d]
                                                                  (queue.put_nowait d)))
                                                 (fn []
                                                   (let [data (nio.first [queue.get
                                                                          future.wait])]
                                                     (if data data
                                                         (while (not= (queue.size)
                                                                      0)
                                                           (queue.get)))))))
                              :attach (fn [])
                              :result (fn []
                                        (if (= result_code nil)
                                            (future:wait))
                                        (handle_err (nio.uv.fs_close output_fd))
                                        result_code)})))
      diagnostic {:enabled true :severity 1}
      discovery {:concurrent 0 :enabled true}
      floating {; :border ["┏" "━" "┓" "┃" "┛" "━" "┗" "┃"]
                :border :none
                :max_height 0.6
                :max_width 0.6
                :options {}}
      highlights {:adapter_name :NeotestAdapterName
                  :border :NeotestBorder
                  :dir :NeotestDir
                  :expand_marker :NeotestExpandMarker
                  :failed :NeotestFailed
                  :file :NeotestFile
                  :focused :NeotestFocused
                  :indent :NeotestIndent
                  :marked :NeotestMarked
                  :namespace :NeotestNamespace
                  :passed :NeotestPassed
                  :running :NeotestRunning
                  :select_win :NeotestWinSelect
                  :skipped :NeotestSkipped
                  :target :NeotestTarget
                  :test :NeotestTest
                  :unknown :NeotestUnknown
                  :watching :NeotestWatching}
      icons {:child_indent "│"
             :child_prefix "├"
             :collapsed "─"
             :expanded "╮"
             :failed ""
             :final_child_indent " "
             :final_child_prefix "╰"
             :non_collapsible "─"
             :passed ""
             :running ""
             :running_animated {"⠋" "⠙"
                                "⠹" "⠸"
                                "⠼" "⠴"
                                "⠦" "⠧"
                                "⠇" "⠏"}
             :skipped ""
             :unknown ""
             :watching ""}
      jump {:enabled true}
      log_level 3
      output {:enabled true :open_on_run :short}
      output_panel {:enabled true :open "botright split | resize 15"}
      projects {}
      quickfix {:enabled true :open false}
      run {:enabled true}
      running {:concurrent true}
      state {:enabled true}
      status {:enabled true :signs true :virtual_text false}
      strategies {:integrated {:height 40 :width 120}}
      summary {:animated true
               :enabled true
               :expand_errors true
               :follow true
               :mappings {:attach :a
                          :clear_marked :M
                          :clear_target :T
                          :debug :d
                          :debug_marked :D
                          :expand {:<CR> :<2-LeftMouse>}
                          :expand_all :e
                          :jumpto :i
                          :mark :m
                          :next_failed :J
                          :output :o
                          :prev_failed :K
                          :run :r
                          :run_marked :R
                          :short :O
                          :stop :u
                          :target :t
                          :watch :w}
               :open "botright vsplit | vertical resize 50"}
      watch {:enabled true :symbol_queries {}} ;; user commands
      lua_cmd (fn [c] (.. "lua " c))
      commands [[:Neotest
                 (lua_cmd "require('neotest').run.run(vim.fn.expand('%'))")
                 {}]
                [:NeotestStop (lua_cmd "require('neotest').run.stop()") {}]
                [:NeotestNearest
                 (lua_cmd "require('neotest').run.run({strategy='dap'})")
                 {}]
                [:NeotestCurrentFile
                 (lua_cmd "require('neotest').run.run(vim.fn.expand('%'))")
                 {}]
                [:NeotestAllFile
                 (lua_cmd "require('neotest').run.run(vim.loop.cwd())")
                 {}]
                [:NeotestToggleSummary
                 (lua_cmd "require('neotest').summary.toggle()")
                 {}]
                [:NeotestTogglePanel
                 (lua_cmd "require('neotest').output_panel.toggle()")
                 {}]]]
  (neotest.setup {: adapters
                  : benchmark
                  : consumers
                  : default_strategy
                  : diagnostic
                  : discovery
                  : floating
                  : highlights
                  : icons
                  : jump
                  : log_level
                  : output
                  : output_panel
                  : projects
                  : quickfix
                  : run
                  : running
                  : state
                  : status
                  : strategies
                  : summary
                  : watch})
  (each [_ c (ipairs commands)]
    (vim.api.nvim_create_user_command (. c 1) (. c 2) (. c 3))))
