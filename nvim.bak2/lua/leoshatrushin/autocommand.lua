vim.cmd [[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]]

function SetColorscheme()
    local colorschemes = {
        -- css = 'catppuccin',
        -- rust = 'gruvbox',
    }

    local filetype = vim.bo.filetype
    local colorscheme = colorschemes[filetype]

    colorscheme = colorscheme or 'rose-pine'

    vim.cmd.colorscheme(colorscheme)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    if filetype == 'rust' then
        vim.cmd[[highlight Operator guifg=#FE8019]]
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = SetColorscheme
})

local config_home = vim.fn.getenv("XDG_CONFIG_HOME")
if config_home == vim.NIL or config_home == '' then
    config_home = vim.fn.expand("$HOME/.config")
end
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = config_home .. "/kitty/kitty.conf",
    command = "silent !kill -SIGUSR1 $(pgrep kitty)"
})

local tmux_conf = vim.fn.getenv("TMUX_CONF")
if tmux_conf == vim.NIL or tmux_conf == '' then
    tmux_conf = vim.fn.expand("$HOME/.tmux.conf")
end
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = tmux_conf,
    command = "silent !tmux source " .. tmux_conf
})
