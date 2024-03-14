-- [nfnl] Compiled from neovim/fnl/java.fnl by https://github.com/Olical/nfnl, do not edit.
local jdtls = require("jdtls")
local setup = require("jdtls.setup")
local dap = require("jdtls.dap")
local root = setup.find_root({".git", "mvnw", "gradlew"})
local home = os.getenv("HOME")
local work_space = (home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root, ":p:h"):gsub("/", "_"))
local cmd = {args.java_path, "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", ("-Dosgi.sharedConfiguration.area=" .. args.jdtls_config_path), "-Dosgi.sharedConfiguration.area.readOnly=true", "-Dosgi.checkConfiguration=true", "-Dosgi.configuration.c:ascaded=true", "-Dlog.protocol=true", "-Dlog.level=OFF", "-Xms1G", "-Xmx12G", "-Xlog:disable", ("-javaagent:" .. args.lombok_jar_path), "-jar", vim.fn.glob(args.jdtls_jar_pattern), "-data", work_space}
local init_options
local _1_
do
  local tbl = {}
  local debug_jars = vim.split(vim.fn.glob(args.java_debug_jar_pattern, 1), "\n")
  local test_jars = vim.split(vim.fn.glob(args.java_test_jar_pattern, 1), "\n")
  for _, v in ipairs(debug_jars) do
    if ("" ~= v) then
      table.insert(tbl, v)
    else
    end
  end
  for _, v in ipairs(test_jars) do
    if ("" ~= v) then
      table.insert(tbl, v)
    else
    end
  end
  _1_ = tbl
end
init_options = {bundles = _1_}
local enabled = {enabled = true}
local disabled = {enabled = false}
local favoriteStaticMembers = {"org.junit.Assert.*", "org.junit.Assume.*", "org.junit.jupiter.api.Assertions.*", "org.junit.jupiter.api.Assumptions.*", "org.junit.jupiter.api.DynamicContainer.*", "org.junit.jupiter.api.DynamicTest.*", "org.assertj.core.api.Assertions.*", "org.mockito.Mockito.*", "org.mockito.ArgumentMatchers.*", "org.mockito.Answers.*", "org.mockito.Mockito.*"}
local filteredTypes = {"java.awt.*", "com.sun.*", "sun.*", "jdk.*", "org.graalvm.*", "io.micrometer.shaded.*"}
local completion = {enabled = true, postfix = enabled, chain = enabled, lazyResolveTextEdit = enabled, favoriteStaticMembers = favoriteStaticMembers, filteredTypes = filteredTypes, guessMethodArguments = "auto", importOrder = {"#", "java", "javax", "jakarta", "org", "com", ""}, matchCase = "firstletter", maxResults = 50}
local configuration = {runtimes = args.runtimes, updateBuildConfiguration = "interactive"}
local eclipse = {downloadSources = false}
local errors = {incompleteClasspath = {severity = "ignore"}}
local executeCommand = enabled
local foldingRange = enabled
local format = enabled
local implementationsCodeLens = enabled
local import = {gradle = {offline = enabled}, maven = {offline = enabled}}
local inlayhints = {parameterNames = enabled}
local jdt = {ls = {lombokSupport = enabled, protobufSupport = enabled, androidSupport = enabled}}
local maven = {downloadSources = true, updateSnapshots = true}
local maxConcurrentBuilds = 8
local project = {encoding = "ignore", referencedLibraries = {"lib/**/*.jar"}}
local quickfix = {showAt = "line"}
local referenceCodeLens = enabled
local references = {includeAccessors = true, includeDecompiledSources = true}
local rename = enabled
local saveActions = {organizeImports = false}
local selectionRange = enabled
local signatureHelp = {enabled = true, description = enabled}
local symbols = {includeSourceMethodDeclarations = true}
local templates = {fileHeader = {}, typeComment = {}}
local trace = {server = "off"}
local edit = {smartSemicolonDetection = enabled, validateAllOpenBuffersOnChanges = false}
local compile = {nullAnalysis = {nonnull = {"javax.annotation.Nonnull", "org.eclipse.jdt.annotation.NonNull", "org.springframework.lang.NonNull"}, nullable = {"javax.annotation.Nullable", "org.eclipse.jdt.annotation.Nullable", "org.springframework.lang.Nullable"}, mode = "interactive"}}
local settings = {java = {autobuild = disabled, completion = completion, configuration = configuration, eclipse = eclipse, errors = errors, executeCommand = executeCommand, foldingRange = foldingRange, format = format, implementationsCodeLens = implementationsCodeLens, import = import, jdt = jdt, maven = maven, maxConcurrentBuilds = maxConcurrentBuilds, project = project, quickfix = quickfix, referenceCodeLens = referenceCodeLens, references = references, rename = rename, saveActions = saveActions, selectionRange = selectionRange, signatureHelp = signatureHelp, symbols = symbols, templates = templates, trace = trace, edit = edit, compile = compile}}
local flags = {server_side_fuzzy_completion = true}
local capabilities = dofile(args.capabilities_path)
local on_attach
local function _4_(client, bufnr)
  dofile(args.on_attach_path)(client, bufnr)
  setup.add_commands()
  jdtls.setup_dap({hotcodereplace = "auto"})
  return dap.setup_dap_main_class_configs()
end
on_attach = _4_
local handlers
local function _5_()
end
handlers = {["language/status"] = _5_}
local user_commands = {JdtTestClass = jdtls.test_class, JdtTestNearestMethod = jdtls.test_nearest_method}
jdtls.jol_path = args.jol_jar_path
jdtls.start_or_attach({root_dir = root, cmd = cmd, init_options = init_options, settings = settings, flags = flags, capabilities = capabilities, on_attach = on_attach, handlers = handlers})
for k, v in pairs(user_commands) do
  vim.api.nvim_create_user_command(k, v, {})
end
return nil
