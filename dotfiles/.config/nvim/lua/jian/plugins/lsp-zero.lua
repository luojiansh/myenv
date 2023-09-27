return {
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            config = function()
                -- Learn the keybindings, see :help lsp-zero-keybindings
                -- Learn to configure LSP servers, see :help lsp-zero-api-showcase
                local lsp = require('lsp-zero')
                lsp.preset('recommended')


                lsp.ensure_installed({
                    'tsserver',
                    'eslint',
                    'lua_ls',
                    'rust_analyzer',
                    'gopls',
                    'ltex',
                    'bashls',
                })

                -- (Optional) Configure lua language server for neovim
                lsp.nvim_workspace()

                lsp.setup()

                ---
                -- Setup haskell LSP
                ---
                local hls_lsp = require('lsp-zero').build_options('hls', {})

                vim.g.haskell_tools = {
                    hls = {
                        capabilities = hls_lsp.capabilities,
                    }
                }

                -- Autocmd that will actually be in charging of starting hls
                local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', {clear = true})
                vim.api.nvim_create_autocmd('FileType', {
                    group = hls_augroup,
                    pattern = {'haskell', 'lhaskell', 'cabal', 'cabalproject'},
                    callback = function()
                        ---
                        -- Suggested keymaps from the quick setup section:
                        -- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
                        ---

                        local ht = require('haskell-tools')
                        local bufnr = vim.api.nvim_get_current_buf()
                        local def_opts = { noremap = true, silent = true, buffer = bufnr, }
                        -- haskell-language-server relies heavily on codeLenses,
                        -- so auto-refresh (see advanced configuration) is enabled by default
                        vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
                        -- Hoogle search for the type signature of the definition under the cursor
                        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
                        -- Evaluate all code snippets
                        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
                        -- Toggle a GHCi repl for the current package
                        vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
                        -- Toggle a GHCi repl for the current buffer
                        vim.keymap.set('n', '<leader>rf', function()
                            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
                        end, def_opts)
                        vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
                        local hti = require('haskell-tools.internal')
                        hti.start_or_attach()
                        hti.dap_discover()
                    end
                })
            end
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                { 'L3MON4D3/LuaSnip' },
            },
            config = function()
                -- Here is where you configure the autocompletion settings.
                -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

                require('lsp-zero.cmp').extend()

                -- And you can configure cmp even more, if you want to.
                local cmp = require('cmp')
                local cmp_action = require('lsp-zero.cmp').action()

                cmp.setup({
                    mapping = {
                        -- `Enter` key to confirm completion
                        ['<CR>'] = cmp.mapping.confirm({select = false}),

                        -- Ctrl+Space to trigger completion menu
                        ['<C-Space>'] = cmp.mapping.complete(),

                        -- Navigate between snippet placeholder
                        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                        -- Scroll up and down in the completion documentation
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    }
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = 'LspInfo',
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'williamboman/mason-lspconfig.nvim' },
                {
                    'williamboman/mason.nvim',
                    build = function()
                        pcall(vim.cmd, 'MasonUpdate')
                    end,
                },
            },
            config = function()
                -- This is where all the LSP shenanigans will live

                local lsp = require('lsp-zero')

                lsp.on_attach(function(client, bufnr)
                    lsp.default_keymaps({ buffer = bufnr })
                end)

                -- (Optional) Configure lua language server for neovim
                require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

                lsp.setup()
            end
        }

    }
}
