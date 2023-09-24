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
                { '<leader>pf', builtin.find_files, desc = 'find files' },
                { '<C-p>',      builtin.git_files,  desc = 'git files' },
                {
                    '<leader>ps',
                    function()
                        builtin.grep_string({ search = vim.fn.input("Grep > ") })
                    end,
                    desc = 'grep string'
                },
                { '<leader>vh', builtin.help_tags, desc = 'help tags' }
            }
        else
            return {}
        end
    end
}
