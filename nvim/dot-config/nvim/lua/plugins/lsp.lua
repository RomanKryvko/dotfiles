return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for Neovim
        { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { "j-hui/fidget.nvim",       opts = {} },

        -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        { "folke/neodev.nvim",       opts = {} },
    },
    config = function()
        --  This function gets run when an LSP attaches to a particular buffer.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                map(
                    "<leader>ws",
                    require("telescope.builtin").lsp_dynamic_workspace_symbols,
                    "[W]orkspace [S]ymbols"
                )
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                map("K", vim.lsp.buf.hover, "Hover Documentation")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                -- Sets border style for windows like hover docs or diagnostics
                local border_style = "single"
                local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

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
                    map("<leader>th", function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, "[T]oggle Inlay [H]ints")
                end
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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
                    "--fallback-style=llvm",
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
    end,
}
