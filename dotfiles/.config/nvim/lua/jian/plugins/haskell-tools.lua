return {
    {
        'mrcjkb/haskell-tools.nvim',
        dependencies = {
            'mfussenegger/nvim-dap',
            'nvim-telescope/telescope.nvim',
        },
        version = '^3', -- Recommended
        ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
    }
}
