-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of `help_tags` options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

local actions = require("telescope.actions")
local data = assert(vim.fn.stdpath("data")) --[[@as string]]

local function quickfix_select(prompt_bufnr)
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("copen")  -- Opens the quickfix window
end

require("telescope").setup({
    --  All the info you're looking for is in `:help telescope.setup()`
    defaults = {
        mappings = {
            i = {
                ["<c-enter>"] = "to_fuzzy_refine",
                ["<M-p>"] = actions.move_selection_previous,
                ["<M-n>"] = actions.move_selection_next,
                ["<C-q>"] = quickfix_select,
            },
            n = {
                ["<C-q>"] = quickfix_select,
            }
        },
    },
    pickers = {},
    extensions = {
        wrap_results = true,
        fzf = {},
        -- history = {
        --     path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
        --     limit = 100,
        -- },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
pcall(require("telescope").load_extension, "ui-select")

local find_command = {
    "rg",
    "--files",
    "--hidden",
    "--follow",
    "--no-ignore-vcs",
}

local vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--no-ignore-vcs"
}

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sd", function()
    builtin.find_files({
        find_command = find_command,
    })
end)
vim.keymap.set("n", "<leader>ss", function()
    builtin.live_grep({
        vimgrep_arguments = vimgrep_arguments,
    })
end)
vim.keymap.set('n', 'gs', function()
    builtin.live_grep({
        vimgrep_arguments = vimgrep_arguments,
        default_text = vim.fn.expand('<cword>')
    })
end)
vim.keymap.set("n", "<leader>sb", function()
    builtin.current_buffer_fuzzy_find({ fuzzy = false, case_mode = "ignore_case" })
end)
vim.keymap.set("n", "<leader>sw", builtin.grep_string)
vim.keymap.set("n", "<leader>sh", builtin.help_tags)
vim.keymap.set("n", "<leader>sq", builtin.quickfix, {})
-- useful option: builtin.find_files({cwd=})
--[[
vim.keymap.set("n", "<leader>pc", function()
    builtin.live_grep({
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--case-sensitive", -- Replace '--smart-case' with '--case-sensitive'
        },
    })
end)
--]]
