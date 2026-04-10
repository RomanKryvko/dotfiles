--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Needed for icons
vim.g.have_nerd_font = true

require("config.keymaps")
require("config.autocommands")
require("config.options")
require("config.colorscheme")
