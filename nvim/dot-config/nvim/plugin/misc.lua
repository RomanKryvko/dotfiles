vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- Autoformat
vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
vim.keymap.set("n", "<leader>f",
    function()
        require("conform").format({ async = true, lsp_fallback = true })
    end,
    { desc = "[F]ormat buffer" })

require('conform').setup({
    notify_on_error = false,
    format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
    end,
})

vim.pack.add({
    "https://github.com/folke/todo-comments.nvim",
    'https://github.com/nvim-lua/plenary.nvim',
})
require("todo-comments").setup({ signs = false })
