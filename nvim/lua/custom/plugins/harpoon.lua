return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<M-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            -- for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            --     vim.keymap.set("n", string.format("<space>%d", idx), function()
            --         harpoon:list():select(idx)
            --     end)
            -- end
            for i, v in ipairs({ "j", "k", "l", ";" }) do
                vim.keymap.set("n", string.format("<M-%s>", v), function()
                    harpoon:list():select(i)
                end)
            end
        end,
    },
}
