return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                columns = { "icon" },
                view_options = {
                    show_hidden = true,
                },
            })
            -- another possiblity - switch window
            vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Open parent directory" })
        end,
    },
}
