-- [nfnl] Compiled from neovim/fnl/early-retirement.fnl by https://github.com/Olical/nfnl, do not edit.
local M = require("early-retirement")
return M.setup({retirementAgeMins = 20, ignoredFiletypes = {}, ignoreAltFile = true, ignoreUnsavedChangesBufs = true, ignoreSpecialBuftypes = true, notificationOnAutoClose = false})
