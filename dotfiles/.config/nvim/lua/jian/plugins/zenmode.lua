function ZenModeWide()
    require("zen-mode").setup {
        window = {
            width = 90,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
end

function ZenModeNarrow()
    require("zen-mode").setup {
        window = {
            width = 80,
            options = {}
        },
    }
    require("zen-mode").toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
end

return {
    "folke/zen-mode.nvim",
    keys = function()
        return {
            {"<leader>zz", ZenModeWide, desc="Toggle zen mode wide"},
            {"<leader>zZ", ZenModeNarrow, desc="Toggle zen mode narrow"},
        }
    end
}
