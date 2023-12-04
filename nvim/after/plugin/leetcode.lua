vim.api.nvim_set_keymap('n', '<leader>ll', ':LeetCodeList<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>lt', ':LeetCodeTest<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ls', ':LeetCodeSubmit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>li', ':LeetCodeSignIn<cr>', {noremap = true})

vim.g.leetcode_browser = 'chrome'
vim.g.leetcode_solution_filetype = 'javascript'
