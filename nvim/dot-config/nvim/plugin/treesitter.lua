vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
-- Prefer git instead of curl in order to improve connectivity in some environments
require("nvim-treesitter.install").prefer_git = true

local ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "typescript",
}
local treesitter = require("nvim-treesitter")
treesitter.install(ensure_installed)

local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
            vim.treesitter.start(args.buf)
        end
    end,
})
