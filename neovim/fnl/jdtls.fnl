(let [java_path args.java_path
      runtimes args.runtimes
      lombok_jar_path args.lombok_jar_path
      jol_jar_path args.jol_jar_path
      jdtls_jar_pattern args.jdtls_jar_pattern
      java_debug_jar_pattern args.java_debug_jar_pattern
      java_test_jar_pattern args.java_test_jar_pattern
      jdtls_config_path args.jdtls_config_path
      on_attach_path args.on_attach_path
      capabilities_path args.capabilities_path
      jdtls (require :jdtls)
      setup (require :jdtls.setup)
      dap (require :jdtls.dap)
      bundles (let [tbl []
                    debug_jars (vim.split (vim.fn.glob java_debug_jar_pattern 1)
                                          "\n")
                    test_jars (vim.split (vim.fn.glob java_test_jar_pattern 1)
                                         "\n")]
                (each [_ v (ipairs debug_jars)]
                  (if (not= "" v)
                      (table.insert tbl v)))
                (each [_ v (ipairs test_jars)]
                  (if (not= "" v)
                      (table.insert tbl v)))
                tbl)
      enabled {:enabled true}
      disabled {:enabled false}
      settings {;; https://github.com/eclipse/eclipse.jdt.ls/blob/master/org.eclipse.jdt.ls.core/src/org/eclipse/jdt/ls/core/internal/preferences/Preferences.java
                ;; https://github.com/redhat-developer/vscode-java/blob/master/package.json
                :java {:autobuild disabled
                       :completion {:enabled true
                                    :postfix enabled
                                    :chain enabled
                                    :lazyResolveTextEdit disabled
                                    :favoriteStaticMembers [:org.junit.Assert.*
                                                            :org.junit.Assume.*
                                                            :org.junit.jupiter.api.Assertions.*
                                                            :org.junit.jupiter.api.Assumptions.*
                                                            :org.junit.jupiter.api.DynamicContainer.*
                                                            :org.junit.jupiter.api.DynamicTest.*
                                                            :org.assertj.core.api.Assertions.*
                                                            :org.mockito.Mockito.*
                                                            :org.mockito.ArgumentMatchers.*
                                                            :org.mockito.Answers.*
                                                            :org.mockito.Mockito.*]
                                    :filteredTypes [:java.awt.*
                                                    :com.sun.*
                                                    :sun.*
                                                    :jdk.*
                                                    :org.graalvm.*
                                                    :io.micrometer.shaded.*]
                                    ; "auto" | "off" | "insertParameterNames" | "insertBestGuessedArguments", default is "auto"
                                    :guessMethodArguments :auto
                                    ; static imports are prefixed with a '#'
                                    :importOrder ["#"
                                                  :java
                                                  :javax
                                                  :jakarta
                                                  :org
                                                  :com
                                                  ""]
                                    ; "off" | "firstletter"
                                    :matchCase :firstletter
                                    ; default is 50
                                    :maxResults 50}
                       :configuration {: runtimes
                                       ;  "disabled" | "interactive" | "automatic", default is "interactive"
                                       :updateBuildConfiguration :interactive}
                       :eclipse {:downloadSources false}
                       :errors {:incompleteClasspath {:severity :ignore}}
                       :executeCommand enabled
                       :foldingRange enabled
                       ; use none-ls
                       :format disabled
                       :implementationsCodeLens enabled
                       :import {:gradle {:offline enabled}
                                :maven {:offline enabled}}
                       :inlayhints {:parameterNames enabled}
                       :jdt {:ls {:lombokSupport enabled
                                  :protobufSupport enabled
                                  :androidSupport enabled}}
                       :maven {:downloadSources true :updateSnapshots true}
                       ; default is 1
                       :maxConcurrentBuilds 2
                       :project {; "ignore" | "warning" | "setDefault", default is "ignore"
                                 :encoding :ignore
                                 :referencedLibraries [:lib/**/*.jar]}
                       :quickfix {; "line" | "problem", default is "line"
                                  :showAt :line}
                       :referenceCodeLens enabled
                       :references {:includeAccessors true
                                    :includeDecompiledSources true}
                       :rename enabled
                       :saveActions {:organizeImports false}
                       :selectionRange enabled
                       :signatureHelp {:enabled true :description enabled}
                       :symbols {:includeSourceMethodDeclarations true}
                       :templates {:fileHeader [] :typeComment []}
                       :trace {; "off" | "messages" | "verbose, default is "off
                               :server :off}
                       :edit {:validateAllOpenBuffersOnChanges false
                              :smartSemicolonDetection enabled}
                       :compile {:nullAnalysis {:nonnull [:javax.annotation.Nonnull
                                                          :org.eclipse.jdt.annotation.NonNull
                                                          :org.springframework.lang.NonNull]
                                                :nullable [:javax.annotation.Nullable
                                                           :org.eclipse.jdt.annotation.Nullable
                                                           :org.springframework.lang.Nullable]
                                                ; "disabled" | "interactive" | "automatic", default is "interactive"
                                                :mode :interactive}}}}
      init_options {: bundles}
      flags {; ?????????????
             :allow_incremental_sync true
             :server_side_fuzzy_completion true}
      handlers {;; use `fidget-nvim`
                :language/status (fn [])}
      mk_config (fn []
                  (let [root_dir (setup.find_root [:.git :mvnw :gradlew])
                        full_path (: (vim.fn.fnamemodify root_dir ":p:h") :gsub
                                     "/" "_")
                        work_space (.. (os.getenv :HOME)
                                       :/.local/share/eclipse/ full_path)]
                    {:on_attach (fn [client bufnr]
                                  ((dofile on_attach_path) client bufnr)
                                  (jdtls.setup_dap {:hotcodereplace :auto})
                                  (setup.add_commands)
                                  (dap.setup_dap_main_class_configs)
                                  nil)
                     :capabilities (dofile capabilities_path)
                     :cmd [java_path
                           ; JDWPの有効化 デバッグ用途
                           ; "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044"
                           :-Declipse.application=org.eclipse.jdt.ls.core.id1
                           :-Dosgi.bundles.defaultStartLevel=4
                           :-Declipse.product=org.eclipse.jdt.ls.core.product
                           (.. :-Dosgi.sharedConfiguration.area=
                               jdtls_config_path)
                           :-Dosgi.sharedConfiguration.area.readOnly=true
                           :-Dosgi.checkConfiguration=true
                           "-Dosgi.configuration.c:ascaded=true"
                           :-Dlog.protocol=true
                           ; ログレベル設定
                           :-Dlog.level=OFF
                           ; ヒープ初期サイズ
                           :-Xms1G
                           ; ヒープ最大サイズ
                           :-Xmx12G
                           ; ログ無効化
                           "-Xlog:disable"
                           ; lombok jar
                           (.. "-javaagent:" lombok_jar_path)
                           ; jdtls jar
                           :-jar
                           (vim.fn.glob jdtls_jar_pattern)
                           :-data
                           work_space]
                     : root_dir
                     : settings
                     : init_options
                     : flags
                     : handlers}))
      user_commands_opts {}
      user_commands {:JdtAttach (fn [] (jdtls.start_or_attach (mk_config)))
                     :JdtTestClass jdtls.test_class
                     :JdtTestNearestMethod jdtls.test_nearest_method}]
  (set jdtls.jol_path jol_jar_path)
  (jdtls.start_or_attach (mk_config))
  (vim.api.nvim_create_autocmd [:FileType]
                               {:pattern [:java]
                                :callback (fn []
                                            (jdtls.start_or_attach (mk_config)))})
  (each [k v (pairs user_commands)]
    (vim.api.nvim_create_user_command k v user_commands_opts)))
