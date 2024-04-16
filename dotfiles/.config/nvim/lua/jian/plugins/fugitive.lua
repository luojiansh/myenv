return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            {"<leader>gs", vim.cmd.Git, desc="Git fugitive"},
            {"<leader>gb", '<cmd>Git blame<cr>', desc="Git blame"}
        }
    },
}
