return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            {"<leader>gs", vim.cmd.Git, desc="git fugitive"},
            {"<leader>gb", '<cmd>Git blame<cr>', desc="git blame"}
        }
    },
}
