return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local oil = require("oil")

            local function enter_action()
                local entry = oil.get_cursor_entry()
                if vim.g.neovim_in_intellij and entry and entry.type == 'file' then
                    local path = oil.get_current_dir() .. "/" .. entry.name
                    vim.fn.jobstart("idea " .. path, { detach = true })
                    vim.cmd("wqa")
                else
                    oil.select()
                end
            end

            oil.setup({
                columns = { "icon" },
                view_options = {
                    is_hidden_file = function(name)
                        return name == ".."
                    end,
                },
                keymaps = {
                    ["<CR>"] = enter_action,
                }
            })
            -- another possiblity - switch window
            vim.keymap.set("n", "-", vim.cmd.Oil, { desc = "Open parent directory" })
        end,
    },
}
