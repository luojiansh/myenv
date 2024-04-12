return {
    {
        "theprimeagen/harpoon",
        keys = function()
            local ok, mark = pcall(require, "harpoon.mark")
            if ok then
                local ui = require("harpoon.ui")

                return {
                    { "<leader>a", mark.add_file, desc="add file" },
                    { "<leader>d", mark.clear_all, desc="clear all" },
                    { "<C-t>",     ui.toggle_quick_menu, desc="toggle menu" },
                    { "<C-h>",     function() ui.nav_file(1) end, desc="nav file 1"},
                    { "<C-n>",     function() ui.nav_file(2) end, desc="nav file 2" },
                    { "<C-e>",     function() ui.nav_file(3) end, desc="nav file 3" },
                    { "<C-i>",     function() ui.nav_file(4) end, desc="nav file 4" }
                }
            else
                return {}
            end
        end
    }
}
