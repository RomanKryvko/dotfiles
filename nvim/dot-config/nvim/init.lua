--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Needed for icons
vim.g.have_nerd_font = true

require("config.keymaps")
require("config.autocommands")
require("config.options")

-- NOTE: plugin directory should be sourced automatically, but it didn't work for me
require("plugin.00-colorscheme")
require("plugin.treesitter")
require("plugin.misc")
require("plugin.mini")
require("plugin.completion")
require("plugin.lsp")
require("plugin.telescope")

require("config.colorscheme")
