--  See `:help lua-guide-autocommands`

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function() vim.highlight.on_yank() end,
})

-- autoreload kitty conf
local config_home = vim.fn.getenv("XDG_CONFIG_HOME") or vim.fn.expand("$HOME/.config")
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload kitty conf on save",
    pattern = config_home .. "/kitty/kitty.conf",
    command = "silent !kill -SIGUSR1 $(pgrep kitty)",
})

-- autoreload tmux conf
local tmux_conf = vim.fn.getenv("TMUX_CONF") or vim.fn.expand("$HOME/.tmux.conf")
vim.api.nvim_create_autocmd("BufWritePost", {
    desc = "Reload tmux conf on save",
    pattern = tmux_conf,
    command = "silent !tmux source " .. tmux_conf,
})
