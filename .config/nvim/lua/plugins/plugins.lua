return {
    {
        -- Comments plugin
        "numToStr/Comment.nvim",

        -- Git signs plugin
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            },
        },

        -- Plugin to show pending keybinds.
        {
            "folke/which-key.nvim",
            event = "VimEnter", -- Sets the loading event to 'VimEnter'
            opts = {
                icons = {
                    mappings = vim.g.have_nerd_font,
                    keys = vim.g.have_nerd_font and {} or {
                        Up = "<Up> ",
                        Down = "<Down> ",
                        Left = "<Left> ",
                        Right = "<Right> ",
                        C = "<C-…> ",
                        M = "<M-…> ",
                        D = "<D-…> ",
                        S = "<S-…> ",
                        CR = "<CR> ",
                        Esc = "<Esc> ",
                        ScrollWheelDown = "<ScrollWheelDown> ",
                        ScrollWheelUp = "<ScrollWheelUp> ",
                        NL = "<NL> ",
                        BS = "<BS> ",
                        Space = "<Space> ",
                        Tab = "<Tab> ",
                        F1 = "<F1>",
                        F2 = "<F2>",
                        F3 = "<F3>",
                        F4 = "<F4>",
                        F5 = "<F5>",
                        F6 = "<F6>",
                        F7 = "<F7>",
                        F8 = "<F8>",
                        F9 = "<F9>",
                        F10 = "<F10>",
                        F11 = "<F11>",
                        F12 = "<F12>",
                    },
                },
            },
        },

        -- Telescople Fuzzy Finder plugin (files, lsp, etc)
        {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            branch = "0.1.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    cond = function()
                        return vim.fn.executable("make") == 1
                    end,
                },
                { "nvim-telescope/telescope-ui-select.nvim" },
                { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
            },
            config = function()
                -- [[ Configure Telescope ]]
                require("telescope").setup({
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown(),
                        },
                    },
                })

                -- Enable Telescope extensions if they are installed
                pcall(require("telescope").load_extension, "fzf")
                pcall(require("telescope").load_extension, "ui-select")

                -- See `:help telescope.builtin`
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
                vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
                vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
                vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
                vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
                vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
                vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
                vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
                vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find,
                    { desc = "[/] Fuzzily search in current buffer" })

                -- It's also possible to pass additional configuration options.
                --  See `:help telescope.builtin.live_grep()` for information about particular keys
                vim.keymap.set("n", "<leader>s/", function()
                    builtin.live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end, { desc = "[S]earch [/] in Open Files" })

                -- Shortcut for searching your Neovim configuration files
                vim.keymap.set("n", "<leader>sn", function()
                    builtin.find_files({ cwd = vim.fn.stdpath("config") })
                end, { desc = "[S]earch [N]eovim files" })
            end,
        },

        -- Autoformat
        {
            "stevearc/conform.nvim",
            lazy = false,
            keys = {
                {
                    "<leader>f",
                    function()
                        require("conform").format({ async = true, lsp_fallback = true })
                    end,
                    mode = "",
                    desc = "[F]ormat buffer",
                },
            },
            opts = {
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
            },
        },

        -- Autocompletion
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                {
                    "L3MON4D3/LuaSnip",
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                            return
                        end
                        return "make install_jsregexp"
                    end)(),
                },
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
            },
            config = function()
                -- See `:help cmp`
                local cmp = require("cmp")
                local luasnip = require("luasnip")
                luasnip.config.setup({})

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end,
                    },
                    completion = { completeopt = "menu,menuone,noinsert" },

                    -- For info on mappings see `:help ins-completion`
                    mapping = cmp.mapping.preset.insert({
                        ["<CR>"] = cmp.mapping.confirm({ select = true }),
                        ["<Tab>"] = cmp.mapping.select_next_item(),
                        ["<S-Tab>"] = cmp.mapping.select_prev_item(),

                        -- Think of <c-l> as moving to the right of your snippet expansion.
                        --  So if you have a snippet that's like:
                        --  function $name($args)
                        --    $body
                        --  end
                        --
                        -- <c-l> will move you to the right of each of the expansion locations.
                        -- <c-h> is similar, except moving you backwards.
                        ["<C-l>"] = cmp.mapping(function()
                            if luasnip.expand_or_locally_jumpable() then
                                luasnip.expand_or_jump()
                            end
                        end, { "i", "s" }),
                        ["<C-h>"] = cmp.mapping(function()
                            if luasnip.locally_jumpable(-1) then
                                luasnip.jump(-1)
                            end
                        end, { "i", "s" }),
                    }),
                    sources = {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                        { name = "path" },
                    },
                })
            end,
        },

        -- Highlight todo, notes, etc in comments
        {
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },

        { -- Collection of various small independent plugins/modules
            "echasnovski/mini.nvim",
            config = function()
                -- Better Around/Inside textobjects
                require("mini.ai").setup({ n_lines = 500 })

                -- Add/delete/replace surroundings (brackets, quotes, etc.)
                require("mini.surround").setup()

                -- Auto brackets / quotes pairs
                require("mini.pairs").setup()

                -- Tabline
                require("mini.tabline").setup()

                -- Simple and easy statusline.
                local statusline = require("mini.statusline")
                statusline.setup({ use_icons = vim.g.have_nerd_font })

                ---@diagnostic disable-next-line: duplicate-set-field
                statusline.section_location = function()
                    return "%2l:%-2v|%L"
                end
            end,
        },
        { -- Highlight, edit, and navigate code
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            opts = {
                ensure_installed = { "bash", "c", "diff", "html", "lua", "luadoc", "markdown", "vim", "vimdoc" },
                -- Autoinstall languages that are not installed
                auto_install = true,
                highlight = {
                    enable = true,
                    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                    --  If you are experiencing weird indenting issues, add the language to
                    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                    additional_vim_regex_highlighting = { "ruby" },
                },
                indent = { enable = true, disable = { "ruby" } },
            },
            config = function(_, opts)
                -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

                -- Prefer git instead of curl in order to improve connectivity in some environments
                require("nvim-treesitter.install").prefer_git = true
                ---@diagnostic disable-next-line: missing-fields
                require("nvim-treesitter.configs").setup(opts)
            end,
        },
    },
}
