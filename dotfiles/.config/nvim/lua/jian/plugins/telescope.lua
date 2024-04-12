return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.1',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
    keys = function()
        local ok, builtin = pcall(require, 'telescope.builtin')
        if ok then
            return {
                { '<leader>ff', builtin.find_files, desc = 'find files' },
                { '<leader>fg', builtin.live_grep,  desc = 'live grep' },
                { '<leader>fb', builtin.buffers,    desc = 'find buffer' },
                { '<leader>gf',      builtin.git_files,  desc = 'git files' },
                {
                    '<leader>fs',
                    function()
                        builtin.grep_string({ search = vim.fn.input("Grep > ") })
                    end,
                    desc = 'grep string'
                },
                { '<leader>fh', builtin.help_tags, desc = 'help tags' }
            }
        else
            return {}
        end
    end
}
