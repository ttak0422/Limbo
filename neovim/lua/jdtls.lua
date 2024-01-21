-- [nfnl] Compiled from neovim/fnl/jdtls.fnl by https://github.com/Olical/nfnl, do not edit.
local java_path = args.java_path
local runtimes = args.runtimes
local lombok_jar_path = args.lombok_jar_path
local jol_jar_path = args.jol_jar_path
local jdtls_jar_pattern = args.jdtls_jar_pattern
local java_debug_jar_pattern = args.java_debug_jar_pattern
local java_test_jar_pattern = args.java_test_jar_pattern
local jdtls_config_path = args.jdtls_config_path
local on_attach_path = args.on_attach_path
local capabilities_path = args.capabilities_path
local jdtls = require("jdtls")
local setup = require("jdtls.setup")
local dap = require("jdtls.dap")
local bundles
do
  local tbl = {}
  local debug_jars = vim.split(vim.fn.glob(java_debug_jar_pattern, 1), "\n")
  local test_jars = vim.split(vim.fn.glob(java_test_jar_pattern, 1), "\n")
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
  bundles = tbl
end
local enabled = {enabled = true}
local disabled = {enabled = false}
local settings = {java = {autobuild = enabled, completion = {enabled = true, postfix = enabled, chain = enabled, lazyResolveTextEdit = disabled, favoriteStaticMembers = {"org.junit.Assert.*", "org.junit.Assume.*", "org.junit.jupiter.api.Assertions.*", "org.junit.jupiter.api.Assumptions.*", "org.junit.jupiter.api.DynamicContainer.*", "org.junit.jupiter.api.DynamicTest.*", "org.assertj.core.api.Assertions.*", "org.mockito.Mockito.*", "org.mockito.ArgumentMatchers.*", "org.mockito.Answers.*", "org.mockito.Mockito.*"}, filteredTypes = {"java.awt.*", "com.sun.*", "sun.*", "jdk.*", "org.graalvm.*", "io.micrometer.shaded.*"}, guessMethodArguments = "auto", importOrder = {"#", "java", "javax", "jakarta", "org", "com", ""}, matchCase = "firstletter", maxResults = 50}, configuration = {runtimes = runtimes, updateBuildConfiguration = "interactive"}, eclipse = {downloadSources = false}, errors = {incompleteClasspath = {severity = "ignore"}}, executeCommand = enabled, foldingRange = enabled, format = disabled, implementationsCodeLens = enabled, import = {gradle = {offline = enabled}, maven = {offline = enabled}}, inlayhints = {parameterNames = enabled}, jdt = {ls = {lombokSupport = enabled, protobufSupport = enabled, androidSupport = enabled}}, maven = {downloadSources = true, updateSnapshots = true}, maxConcurrentBuilds = 2, project = {encoding = "ignore", referencedLibraries = {"lib/**/*.jar"}}, quickfix = {showAt = "line"}, referenceCodeLens = enabled, references = {includeAccessors = true, includeDecompiledSources = true}, rename = enabled, saveActions = {organizeImports = false}, selectionRange = enabled, signatureHelp = {enabled = true, description = enabled}, symbols = {includeSourceMethodDeclarations = true}, templates = {fileHeader = {}, typeComment = {}}, trace = {server = "off"}, edit = {smartSemicolonDetection = enabled, validateAllOpenBuffersOnChanges = false}, compile = {nullAnalysis = {nonnull = {"javax.annotation.Nonnull", "org.eclipse.jdt.annotation.NonNull", "org.springframework.lang.NonNull"}, nullable = {"javax.annotation.Nullable", "org.eclipse.jdt.annotation.Nullable", "org.springframework.lang.Nullable"}, mode = "interactive"}}}}
local init_options = {bundles = bundles}
local flags = {allow_incremental_sync = true, server_side_fuzzy_completion = true}
local handlers
local function _3_()
end
handlers = {["language/status"] = _3_}
local mk_config
local function _4_()
  local root_dir = setup.find_root({".git", "mvnw", "gradlew"})
  local full_path = vim.fn.fnamemodify(root_dir, ":p:h"):gsub("/", "_")
  local work_space = (os.getenv("HOME") .. "/.local/share/eclipse/" .. full_path)
  local function _5_(client, bufnr)
    dofile(on_attach_path)(client, bufnr)
    jdtls.setup_dap({hotcodereplace = "auto"})
    setup.add_commands()
    dap.setup_dap_main_class_configs()
    return nil
  end
  return {on_attach = _5_, capabilities = dofile(capabilities_path), cmd = {java_path, "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", ("-Dosgi.sharedConfiguration.area=" .. jdtls_config_path), "-Dosgi.sharedConfiguration.area.readOnly=true", "-Dosgi.checkConfiguration=true", "-Dosgi.configuration.c:ascaded=true", "-Dlog.protocol=true", "-Dlog.level=OFF", "-Xms1G", "-Xmx12G", "-Xlog:disable", ("-javaagent:" .. lombok_jar_path), "-jar", vim.fn.glob(jdtls_jar_pattern), "-data", work_space}, root_dir = root_dir, settings = settings, init_options = init_options, flags = flags, handlers = handlers}
end
mk_config = _4_
local user_commands_opts = {}
local user_commands
local function _6_()
  return jdtls.start_or_attach(mk_config())
end
user_commands = {JdtAttach = _6_, JdtTestClass = jdtls.test_class, JdtTestNearestMethod = jdtls.test_nearest_method}
jdtls.jol_path = jol_jar_path
jdtls.start_or_attach(mk_config())
local function _7_()
  return jdtls.start_or_attach(mk_config())
end
vim.api.nvim_create_autocmd({"FileType"}, {pattern = {"java"}, callback = _7_})
for k, v in pairs(user_commands) do
  vim.api.nvim_create_user_command(k, v, user_commands_opts)
end
return nil
