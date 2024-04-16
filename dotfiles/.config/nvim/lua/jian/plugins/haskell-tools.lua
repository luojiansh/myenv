return {
    {
        'mrcjkb/haskell-tools.nvim',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-telescope/telescope.nvim',
        },
        version = '^3', -- Recommended
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
        config = function()
            ---
            -- Setup haskell LSP
            ---
            local lsp_zero = require('lsp-zero')

            vim.g.haskell_tools = {
                hls = {
                    capabilities = lsp_zero.get_capabilities()
                }
            }

            -- Autocmd that will actually be in charging of starting hls
            local hls_augroup = vim.api.nvim_create_augroup('haskell-lsp', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = hls_augroup,
                pattern = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
                callback = function()
                    ---
                    -- Suggested keymaps from the quick setup section:
                    -- https://github.com/mrcjkb/haskell-tools.nvim#quick-setup
                    ---

                    local ht = require('haskell-tools')
                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { noremap = true, silent = true, buffer = bufnr, }
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
                    end, opts)
                    vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

                    vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', { desc = 'Show diagnostic' })
                    vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { desc = 'Previous diagnostic' })
                    vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', { desc = 'Next diagnostic' })
                    -- telescope extension
                    require('telescope').load_extension('ht')
                end
            })
        end
    }
}
