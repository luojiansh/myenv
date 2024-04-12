return {
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            {"<leader>gs", vim.cmd.Git, desc="fugitive"},
            {"<leader>gb", vim.cmd.Git, desc="git blame"}
        }
    },
}
