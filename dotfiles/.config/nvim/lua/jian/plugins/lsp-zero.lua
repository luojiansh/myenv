return {
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            cmd = 'LspInfo',
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                { 'neovim/nvim-lspconfig' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'williamboman/mason-lspconfig.nvim' },
                {
                    'williamboman/mason.nvim',
                    build = function()
                        pcall(function() vim.cmd [[MasonUpdate]] end)
                    end,
                },
            },
            config = function()
                local lsp_zero = require('lsp-zero')

                lsp_zero.on_attach(function(client, bufnr)
                    -- see :help lsp-zero-keybindings
                    -- to learn the available actions
                    lsp_zero.default_keymaps({ buffer = bufnr })
                end)

                --- if you want to know more about lsp-zero and mason.nvim
                --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
                require('mason').setup({})
                require('mason-lspconfig').setup({
                    ensure_installed = {
                        'tsserver',
                        'eslint',
                        'lua_ls',
                        'rust_analyzer',
                        'gopls',
                        'ltex',
                        'bashls',
                    },
                    handlers = {
                        function(server_name)
                            require('lspconfig')[server_name].setup({})
                        end,
                        lua_ls = function()
                            -- (Optional) configure lua language server
                            local lua_opts = lsp_zero.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end,
                    }
                })
            end
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                { 'L3MON4D3/LuaSnip' },
                { "rafamadriz/friendly-snippets" },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'hrsh7th/cmp-buffer' },
            },
            config = function()
                -- Here is where you configure the autocompletion settings.
                -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
                -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/api-reference.md#extend_cmpopts

                require('lsp-zero').extend_cmp()

                -- And you can configure cmp even more, if you want to.
                local cmp = require('cmp')
                local cmp_action = require('lsp-zero').cmp_action()
                local cmp_format = require('lsp-zero').cmp_format()

                require('luasnip.loaders.from_vscode').lazy_load()

                cmp.setup({
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                        { name = 'buffer' },
                    }),
                    mapping = cmp.mapping.preset.insert({
                        -- `Enter` key to confirm completion
                        ['<CR>'] = cmp.mapping.confirm({ select = false }),

                        -- Ctrl+Space to trigger completion menu
                        ['<C-Space>'] = cmp.mapping.complete(),

                        -- Navigate between snippet placeholder
                        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                        -- Scroll up and down in the completion documentation
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    }),
                    --- (Optional) Show source name in completion menu
                    formatting = cmp_format,
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body)
                        end,
                    },

                })
            end
        },
    }
}
