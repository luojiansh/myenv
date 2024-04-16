return {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.1',
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
    keys = function()
        local ok, builtin = pcall(require, 'telescope.builtin')
        if ok then
            return {
                { '<leader>ff', builtin.find_files, desc = 'Find files' },
                { '<leader>fg', builtin.live_grep,  desc = 'Live grep' },
                { '<leader>fb', builtin.buffers,    desc = 'Find buffer' },
                { '<leader>gf',      builtin.git_files,  desc = 'Find git files' },
                { '<leader>gr',      builtin.git_commit_range,  desc = 'Find git commit range' },
                {
                    '<leader>fs',
                    function()
                        builtin.grep_string({ search = vim.fn.input("Grep > ") })
                    end,
                    desc = 'Grep string'
                },
                { '<leader>fh', builtin.help_tags, desc = 'Find help tags' }
            }
        else
            return {}
        end
    end
}
