local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<M-p>"] = actions.move_selection_previous,
				["<M-n>"] = actions.move_selection_next,
			},
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>bf", builtin.buffers)
vim.keymap.set("n", "<leader>bs", function()
	builtin.current_buffer_fuzzy_find({ fuzzy = false, case_mode = "ignore_case" })
end)
-- vim.keymap.set('n', '<leader>bs', function() builtin.live_grep({ search_dirs = { '%:p' } }) end)
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>ps", function()
	builtin.live_grep()
end)
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
vim.keymap.set("n", "<leader>w", builtin.quickfix, {})
