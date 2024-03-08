-- [nfnl] Compiled from neovim/fnl/my-tig.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local detour = require("detour")
  local current_dir = vim.fn.expand("%:p:h")
  local ok = detour.Detour()
  if ok then
    vim.cmd.lcd(current_dir)
    vim.cmd.terminal("tig")
    vim.bo.bufhidden = "delete"
    vim.keymap.set("t", "<Esc>", "<Esc>", {buffer = true})
    vim.cmd.startinsert()
    local function _2_()
      local buf_id = vim.api.nvim_get_current_buf()
      local function _3_()
        return vim.cmd(("bd! " .. buf_id))
      end
      return {buffer = buf_id, callback = _3_}
    end
    vim.api.nvim_create_autocmd({"BufLeave"}, _2_())
    local function _4_()
      return vim.api.nvim_feedkeys("i", "n", false)
    end
    return vim.api.nvim_create_autocmd({"TermClose"}, {buffer = vim.api.nvim_get_current_buf(), callback = _4_})
  else
    return nil
  end
end
return vim.api.nvim_create_user_command("TigTermToggle", _1_, {})
