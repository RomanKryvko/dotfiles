vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require("mini.ai").setup({ n_lines = 500 })
-- Add/delete/replace surroundings (brackets, quotes, etc.)
require("mini.surround").setup()
-- Auto brackets / quotes pairs
require("mini.pairs").setup()
require("mini.tabline").setup()
require("mini.comment").setup()
vim.o.completeopt = "menuone,fuzzy,noinsert"
require("mini.completion").setup()

local imap_expr = function(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

_G.cr_action = function()
    -- If there is selected item in popup, accept it with <C-y>
    if vim.fn.complete_info()['selected'] ~= -1 then return '\25' end
    -- Fall back to plain `<CR>`
    return MiniPairs.cr()
end

vim.keymap.set('i', '<CR>', 'v:lua.cr_action()', { expr = true })

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
