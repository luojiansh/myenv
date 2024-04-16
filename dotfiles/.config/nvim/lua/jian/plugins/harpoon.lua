return {
    {
        "theprimeagen/harpoon",
        keys = function()
            local ok, mark = pcall(require, "harpoon.mark")
            if ok then
                local ui = require("harpoon.ui")

                return {
                    { "<leader>ha", mark.add_file, desc="Add file" },
                    { "<leader>hc", mark.clear_all, desc="Clear all" },
                    { "<leader>ht",     ui.toggle_quick_menu, desc="Toggle menu" },
                    { "<leader>h1",     function() ui.nav_file(1) end, desc="Nav file 1"},
                    { "<leader>h2",     function() ui.nav_file(2) end, desc="Nav file 2"},
                    { "<leader>h3",     function() ui.nav_file(3) end, desc="Nav file 3"},
                    { "<leader>h4",     function() ui.nav_file(4) end, desc="Nav file 4"},
                }
            else
                return {}
            end
        end
    }
}
