vim.opt.guicursor = "" -- keep thick cursor in insert mode

vim.opt.nu = true -- absolute line number on current line
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- spaces per tab character
vim.opt.softtabstop = 4 -- spaces per tab operation
vim.opt.shiftwidth = 4 -- spaces per autoindent
vim.opt.expandtab = true -- replace tabs with spaces

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
local cache_home = vim.fn.getenv("XDG_CACHE_HOME")
if cache_home == vim.NIL or cache_home == '' then
    cache_home = vim.fn.expand("$HOME/.cache")
end
vim.opt.undodir = cache_home .. "/nvim/undodir"
vim.opt.undofile = true -- persistent undo

vim.opt.hlsearch = false -- highlight search results
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true -- enable true colors

vim.opt.scrolloff = 16 -- keep 16 lines above and below cursor
vim.opt.signcolumn = "yes" -- sign column: vcs, linters, etc.
vim.opt.isfname:append("@-@") -- allow @ in filenames

vim.opt.updatetime = 50 -- trigger idle events after 50ms

vim.opt.colorcolumn = "80" -- 80 char ruler

vim.opt.inccommand = "nosplit" -- live preview of :s

vim.o.mouse = "a" -- enable mouse support
