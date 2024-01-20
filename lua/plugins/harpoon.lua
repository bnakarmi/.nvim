return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():append()
        end, { desc = "[H]arpoon [M]ark" })
        vim.keymap.set("n", "<leader>hq", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "[H]arpoon [T]oggle Quick Menu" })
        vim.keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
        end, { desc = "[H]arpoon [P]revious" })
        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
        end, { desc = "[H]arpoon [N]ext" })
    end
}
