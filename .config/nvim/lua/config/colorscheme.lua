local ok = pcall(vim.cmd.colorscheme, "gruvbox")
if not ok then
    vim.cmd.colorscheme("retrobox")
end
