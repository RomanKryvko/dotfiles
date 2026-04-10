vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require("mini.ai").setup({ n_lines = 500 })
-- Add/delete/replace surroundings (brackets, quotes, etc.)
require("mini.surround").setup()
-- Auto brackets / quotes pairs
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.comment").setup()

-- Statusline
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
statusline.section_location = function()
    return "%2l:%-2v|%L"
end
-- Disable search count in statusline if already displayed in cmd
if not string.find(vim.o.shortmess, 'S') then
    statusline.section_searchcount = function() end
end
