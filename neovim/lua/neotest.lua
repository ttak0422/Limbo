-- [nfnl] Compiled from neovim/fnl/neotest.fnl by https://github.com/Olical/nfnl, do not edit.
local neotest = require("neotest")
local adapters
local function _1_()
  return vim.fn.getcwd()
end
local function _2_()
  return vim.loop.cwd()
end
local function _3_(name, _rel_path, _root)
  return (name ~= "node_modules")
end
adapters = {require("neotest-jest")({jestConfigFile = "jest.config.js", env = {CI = true}, cwd = _1_}), require("neotest-vim-test")({allow_file_types = {}}), require("neotest-python")({dap = {justMyCode = false}}), require("neotest-java")({junit_jar = args.junit_jar_path, ignore_wrapper = false}), require("neotest-plenary"), require("neotest-golang")({go_test_args = {"-v", "-race", "-count=1", "-timeout=60s", ("-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out")}}), require("neotest-vitest"), require("neotest-rspec"), require("neotest-minitest"), require("neotest-dart")({command = "flutter", use_lsp = true, custom_test_method_names = {}}), require("neotest-rust")({args = {"--no-capture"}, dap_adapter = "lldb"}), require("neotest-elixir"), require("neotest-dotnet"), require("neotest-scala"), require("neotest-haskell"), require("neotest-deno"), (require("neotest-playwright")).adapter({options = {persist_project_selection = true, enable_dynamic_test_discovery = true, preset = "none", get_cwd = _2_, env = {}, extra_args = {}, filter_dir = _3_}})}
local benchmark = {enabled = true}
local consumers = {overseer = require("neotest.consumers.overseer"), playwright = (require("neotest-playwright.consumers")).consumers}
local default_strategy
local function _4_(spec)
  local result_code = nil
  local nio = require("nio")
  local types = require("neotest.types")
  local handle_err
  local function _5_(e)
    return assert(not e, e)
  end
  handle_err = _5_
  local path = nio.fn.tempname()
  local future = nio.control.future()
  local out
  local function _6_(prev, new)
    if not prev then
      return new
    else
      return (prev .. new)
    end
  end
  out = types.FanoutAccum(_6_)
  local cmd = spec.command
  local ctx
  local function _8_(_, d)
    return out:push(table.concat(d, "\n"))
  end
  local function _9_(_, code)
    result_code = code
    return future.set()
  end
  ctx = {cwd = spec.cwd, env = spec.env, pty = true, height = spec.strategy.height, width = spec.strategy.width, on_stdout = _8_, on_exit = _9_}
  local open_err, output_fd = nio.uv.fs_open(path, "w", 438)
  handle_err(open_err)
  local function _10_(data)
    return vim.loop.fs_write(output_fd, data, nil, handle_err)
  end
  out:subscribe(_10_)
  local success, job = pcall(nio.fn.jobstart, cmd, ctx)
  if not success then
    local write_err, _ = nio.uv.fs_write(output_fd, job)
    handle_err(write_err)
    result_code = 1
    future.set()
  else
  end
  local function _12_()
    return (result_code ~= nil)
  end
  local function _13_()
    return path
  end
  local function _14_()
    return nio.fn.jobstop(job)
  end
  local function _15_()
    local queue = nio.control.queue()
    local function _16_(d)
      return queue.put_nowait(d)
    end
    out:subscribe(_16_)
    local function _17_()
      local data = nio.first({queue.get, future.wait})
      if data then
        return data
      else
        while (queue.size() ~= 0) do
          queue.get()
        end
        return nil
      end
    end
    return _17_
  end
  local function _19_()
  end
  local function _20_()
    if (result_code == nil) then
      future:wait()
    else
    end
    handle_err(nio.uv.fs_close(output_fd))
    return result_code
  end
  return {is_complete = _12_, output = _13_, stop = _14_, output_stream = _15_, attach = _19_, result = _20_}
end
default_strategy = _4_
local diagnostic = {enabled = true, severity = 1}
local discovery = {concurrent = 0, enabled = true}
local floating = {border = {"\226\148\143", "\226\148\129", "\226\148\147", "\226\148\131", "\226\148\155", "\226\148\129", "\226\148\151", "\226\148\131"}, max_height = 0.6, max_width = 0.6, options = {}}
local highlights = {adapter_name = "NeotestAdapterName", border = "NeotestBorder", dir = "NeotestDir", expand_marker = "NeotestExpandMarker", failed = "NeotestFailed", file = "NeotestFile", focused = "NeotestFocused", indent = "NeotestIndent", marked = "NeotestMarked", namespace = "NeotestNamespace", passed = "NeotestPassed", running = "NeotestRunning", select_win = "NeotestWinSelect", skipped = "NeotestSkipped", target = "NeotestTarget", test = "NeotestTest", unknown = "NeotestUnknown", watching = "NeotestWatching"}
local icons = {child_indent = "\226\148\130", child_prefix = "\226\148\156", collapsed = "\226\148\128", expanded = "\226\149\174", failed = "\238\170\184", final_child_indent = " ", final_child_prefix = "\226\149\176", non_collapsible = "\226\148\128", passed = "\238\170\178", running = "\238\169\183", running_animated = {["\226\160\139"] = "\226\160\153", ["\226\160\185"] = "\226\160\184", ["\226\160\188"] = "\226\160\180", ["\226\160\166"] = "\226\160\167", ["\226\160\135"] = "\226\160\143"}, skipped = "\238\174\159", unknown = "\238\172\178", watching = "\238\169\176"}
local jump = {enabled = true}
local log_level = 3
local output = {enabled = true, open_on_run = "short"}
local output_panel = {enabled = true, open = "botright split | resize 15"}
local projects = {}
local quickfix = {enabled = true, open = false}
local run = {enabled = true}
local running = {concurrent = true}
local state = {enabled = true}
local status = {enabled = true, signs = true, virtual_text = false}
local strategies = {integrated = {height = 40, width = 120}}
local summary = {animated = true, enabled = true, expand_errors = true, follow = true, mappings = {attach = "a", clear_marked = "M", clear_target = "T", debug = "d", debug_marked = "D", expand = {["<CR>"] = "<2-LeftMouse>"}, expand_all = "e", jumpto = "i", mark = "m", next_failed = "J", output = "o", prev_failed = "K", run = "r", run_marked = "R", short = "O", stop = "u", target = "t", watch = "w"}, open = "botright vsplit | vertical resize 50"}
local watch = {enabled = true, symbol_queries = {}}
local lua_cmd
local function _22_(c)
  return ("lua " .. c)
end
lua_cmd = _22_
local commands = {{"Neotest", lua_cmd("require('neotest').run.run(vim.fn.expand('%'))"), {}}, {"NeotestStop", lua_cmd("require('neotest').run.stop()"), {}}, {"NeotestNearest", lua_cmd("require('neotest').run.run({strategy='dap'})"), {}}, {"NeotestCurrentFile", lua_cmd("require('neotest').run.run(vim.fn.expand('%'))"), {}}, {"NeotestAllFile", lua_cmd("require('neotest').run.run(vim.loop.cwd())"), {}}, {"NeotestToggleSummary", lua_cmd("require('neotest').summary.toggle()"), {}}, {"NeotestTogglePanel", lua_cmd("require('neotest').output_panel.toggle()"), {}}}
neotest.setup({adapters = adapters, benchmark = benchmark, consumers = consumers, default_strategy = default_strategy, diagnostic = diagnostic, discovery = discovery, floating = floating, highlights = highlights, icons = icons, jump = jump, log_level = log_level, output = output, output_panel = output_panel, projects = projects, quickfix = quickfix, run = run, running = running, state = state, status = status, strategies = strategies, summary = summary, watch = watch})
for _, c in ipairs(commands) do
  vim.api.nvim_create_user_command(c[1], c[2], c[3])
end
return nil
