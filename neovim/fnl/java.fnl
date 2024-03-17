(let [BUILD_TIMEOUT 7500 ;; msec
      jdtls (require :jdtls)
      setup (require :jdtls.setup)
      dap (require :jdtls.dap) ;;
      ;; system
      root (setup.find_root [:.git :mvnw :gradlew])
      home (os.getenv :HOME)
      work_space (.. home :/.local/share/eclipse/
                     (: (vim.fn.fnamemodify root ":p:h") :gsub "/" "_"))
      ;; jar
      cmd [args.java_path
           ; JDWPの有効化 デバッグ用途
           ; "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044"
           :-Declipse.application=org.eclipse.jdt.ls.core.id1
           :-Dosgi.bundles.defaultStartLevel=4
           :-Declipse.product=org.eclipse.jdt.ls.core.product
           (.. :-Dosgi.sharedConfiguration.area= args.jdtls_config_path)
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
           (.. "-javaagent:" args.lombok_jar_path)
           ; jdtls jar
           :-jar
           (vim.fn.glob args.jdtls_jar_pattern)
           :-data
           work_space]
      init_options {:bundles (let [tbl []
                                   debug_jars (vim.split (vim.fn.glob args.java_debug_jar_pattern
                                                                      1)
                                                         "\n")
                                   test_jars (vim.split (vim.fn.glob args.java_test_jar_pattern
                                                                     1)
                                                        "\n")]
                               (each [_ v (ipairs debug_jars)]
                                 (if (not= "" v)
                                     (table.insert tbl v)))
                               (each [_ v (ipairs test_jars)]
                                 (if (not= "" v)
                                     (table.insert tbl v)))
                               tbl)}
      ;; language server settings
      enabled {:enabled true}
      disabled {:enabled false}
      favoriteStaticMembers [:org.junit.Assert.*
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
      filteredTypes [:java.awt.*
                     :com.sun.*
                     :sun.*
                     :jdk.*
                     :org.graalvm.*
                     :io.micrometer.shaded.*]
      completion {:enabled true
                  :postfix enabled
                  :chain enabled
                  :lazyResolveTextEdit enabled
                  : favoriteStaticMembers
                  : filteredTypes
                  ;; "auto" | "off" | "insertParameterNames" | "insertBestGuessedArguments", default is "auto"
                  :guessMethodArguments :auto
                  ; static imports are prefixed with a '#'
                  :importOrder ["#" :java :javax :jakarta :org :com ""]
                  ;; "off" | "firstletter"
                  :matchCase :firstletter
                  ;; default is 50
                  :maxResults 50}
      configuration {:runtimes args.runtimes
                     ;;  "disabled" | "interactive" | "automatic", default is "interactive"
                     :updateBuildConfiguration :interactive}
      eclipse {:downloadSources false}
      errors {:incompleteClasspath {:severity :ignore}}
      executeCommand enabled
      foldingRange enabled
      format enabled
      implementationsCodeLens enabled
      import {:gradle {:offline enabled} :maven {:offline enabled}}
      inlayhints {:parameterNames enabled}
      jdt {:ls {:lombokSupport enabled
                :protobufSupport enabled
                :androidSupport enabled}}
      maven {:downloadSources true :updateSnapshots true} ;; default is 1
      maxConcurrentBuilds 8
      project {;; "ignore" | "warning" | "setDefault", default is "ignore"
               :encoding :ignore
               :referencedLibraries [:lib/**/*.jar]}
      quickfix {;; "line" | "problem", default is "line"
                :showAt :line}
      referenceCodeLens enabled
      references {:includeAccessors true :includeDecompiledSources true}
      rename enabled
      saveActions {:organizeImports false}
      selectionRange enabled
      signatureHelp {:enabled true :description enabled}
      symbols {:includeSourceMethodDeclarations true}
      templates {:fileHeader [] :typeComment []}
      trace {;; "off" | "messages" | "verbose, default is "off
             :server :off}
      edit {:validateAllOpenBuffersOnChanges false
            :smartSemicolonDetection enabled}
      compile {:nullAnalysis {:nonnull [:javax.annotation.Nonnull
                                        :org.eclipse.jdt.annotation.NonNull
                                        :org.springframework.lang.NonNull]
                              :nullable [:javax.annotation.Nullable
                                         :org.eclipse.jdt.annotation.Nullable
                                         :org.springframework.lang.Nullable]
                              ; "disabled" | "interactive" | "automatic", default is "interactive"
                              :mode :interactive}}
      settings {:java {:autobuild disabled
                       : completion
                       : configuration
                       : eclipse
                       : errors
                       : executeCommand
                       : foldingRange
                       : format
                       : implementationsCodeLens
                       : import
                       : inlayhints
                       : jdt
                       : maven
                       : maxConcurrentBuilds
                       : project
                       : quickfix
                       : referenceCodeLens
                       : references
                       : rename
                       : saveActions
                       : selectionRange
                       : signatureHelp
                       : symbols
                       : templates
                       : trace
                       : edit
                       : compile}}
      flags {:server_side_fuzzy_completion true} ;;
      ;; client settings
      capabilities (dofile args.capabilities_path)
      on_attach (fn [client bufnr]
                  (let [mk_opts (fn [desc] {:silent true :buffer bufnr : desc})
                        with_compile (fn [f]
                                       (fn []
                                         (if vim.bo.modified
                                             (vim.cmd :w))
                                         (client.request_sync :java/buildWorkspace
                                                              false
                                                              BUILD_TIMEOUT
                                                              bufnr)
                                         (f)))
                        n_keys [[:<LocalLeader>o
                                 jdtls.organize_imports
                                 (mk_opts "[JDTLS] organize imports")]
                                [:<LocalLeader>tc
                                 (with_compile jdtls.test_class)
                                 (mk_opts "[JDTLS] test class")]
                                [:<LocalLeader>tt
                                 (with_compile jdtls.test_nearest_method)
                                 (mk_opts "[JDTLS] test nearest method")]
                                [:<LocalLeader>tl
                                 (with_compile dap.run_last)
                                 (mk_opts "[DAP] run last")]]]
                    ((dofile args.on_attach_path) client bufnr)
                    (setup.add_commands)
                    (jdtls.setup_dap {:hotcodereplace :auto})
                    (dap.setup_dap_main_class_configs)
                    (each [_ k (ipairs n_keys)]
                      (vim.keymap.set :n (. k 1) (. k 2) (. k 3)))))
      handlers {:language/status (fn [])}
      user_commands {:JdtTestClass jdtls.test_class
                     :JdtTestNearestMethod jdtls.test_nearest_method}]
  (set jdtls.jol_path args.jol_jar_path)
  (jdtls.start_or_attach {:root_dir root
                          : cmd
                          : init_options
                          : settings
                          : flags
                          : capabilities
                          : on_attach
                          : handlers})
  (each [k v (pairs user_commands)]
    (vim.api.nvim_create_user_command k v {})))
