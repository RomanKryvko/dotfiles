vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

require("mini.ai").setup({ n_lines = 500 })
-- Add/delete/replace surroundings (brackets, quotes, etc.)
require("mini.surround").setup()
-- Auto brackets / quotes pairs
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.comment").setup()

local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        -- `[` and `]` keys
        { mode = 'n',          keys = '[' },
        { mode = 'n',          keys = ']' },

        -- Built-in completion
        { mode = 'i',          keys = '<C-x>' },

        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },

        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },

        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        -- Window commands
        { mode = 'n',          keys = '<C-w>' },

        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

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
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
    return "%2l:%-2v|%L"
end
-- Disable search count in statusline if already displayed in cmd
if not string.find(vim.o.shortmess, 'S') then
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_searchcount = function() end
end

local extra = require('mini.extra')
extra.setup()
local pick = require('mini.pick')
pick.setup()

local keymap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { desc = desc })
end

keymap("<leader>sh", pick.builtin.help, "[S]earch [H]elp")
keymap("<leader>sk", extra.pickers.keymaps, "[S]earch [K]eymaps")
keymap("<leader>sf", pick.builtin.files, "[S]earch [F]iles")
keymap("<leader>sg", pick.builtin.grep_live, "[S]earch by [G]rep")
keymap("<leader>sd", extra.pickers.diagnostic, "[S]earch [D]iagnostics")
keymap("<leader>sr", pick.builtin.resume, "[S]earch [R]esume")
keymap("<leader>s.", extra.pickers.oldfiles, '[S]earch Recent Files ("." for repeat)')
keymap("<leader><leader>", pick.builtin.buffers, "[ ] Find existing buffers")
keymap("<leader>/", extra.pickers.buf_lines, "[/] Fuzzily search in current buffer")
