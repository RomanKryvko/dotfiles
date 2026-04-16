vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig',
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/j-hui/fidget.nvim",
    "https://github.com/folke/lazydev.nvim",
    'https://github.com/nvim-mini/mini.nvim',
})

require("fidget").setup()
require("lazydev").setup()

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local extra = require('mini.extra')
        -- For available scopes see MiniExtra.pickers.lsp()
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local pick_map = function(keys, scope, desc)
            map(keys, function() extra.pickers.lsp({ scope = scope }) end, desc)
        end

        -- HACK: jump directly to the definition if there's only one option
        local smart_definition = function()
            local params = vim.lsp.util.make_position_params(0, "utf-8")

            vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, _, _)
                if err then
                    vim.notify("LSP definition error: " .. err.message, vim.log.levels.ERROR)
                    return
                end

                if not result or vim.tbl_isempty(result) then
                    vim.notify("No definition found")
                    return
                end

                local locations = vim.islist(result) and result or { result }

                if #locations == 1 then
                    vim.lsp.util.show_document(locations[1], "utf-8", { focus = true })
                else
                    extra.pickers.lsp({ scope = "definition" })
                end
            end)
        end

        map("gd", smart_definition, "[G]oto [D]efinition")
        --NOTE: 'gr' conflicts with built-in LSP gr* keymaps (grr, gri, gra, etc.)
        pick_map("gR", "references", "[G]oto [R]eferences")
        pick_map("<leader>D", "type_definition", "Type [D]efinition")
        pick_map("<leader>ds", "document_symbol", "[D]ocument [S]ymbols")
        pick_map("<leader>ws", "workspace_symbol_live", "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        pick_map("gri", "implementation", "[G]oto [I]mplementation")

        -- Sets border style for windows like hover docs or diagnostics
        local border_style = "single"
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border_style

            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Highlight references of the word under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup =
                vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        -- Inlay hints in  code, if the language server supports them
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            pick_map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, "[T]oggle Inlay [H]ints")
        end
    end,
})

-- Enable the following language servers
local servers = {
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=Google",
        },
    },
    rust_analyzer = {},
    lua_ls = {
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        --HACK: I didn't find a less dirty way to prevent lsp from indexing the entire home directory
        root_dir = function(fname)
            return vim.fs.abspath(fname .. "/..")
        end,
        single_file_support = true,
    },
    ts_ls = {},
    texlab = {},
}
require("mason").setup()

require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

local capabilities = vim.lsp.protocol.make_client_capabilities()
require("mini.completion").setup()
capabilities = vim.tbl_deep_extend("force", capabilities, MiniCompletion.get_lsp_capabilities())

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end,
    },
})
