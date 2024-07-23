vim.g.have_nerd_font = true

local o = vim.opt

o.termguicolors = true -- enable true colors

o.guicursor = "" -- keep thick cursor in insert mode

o.relativenumber = true
o.number = true -- absolute line number on current line
o.signcolumn = "yes" -- sign column: vcs, linters, etc.

o.tabstop = 4 -- spaces per tab character
o.softtabstop = 4 -- spaces per tab operation
o.shiftwidth = 4 -- spaces per autoindent
o.expandtab = true -- replace tabs with spaces

o.smartindent = true

o.wrap = true
o.breakindent = true -- wrapped lines continue on the same indent

o.swapfile = false
o.backup = false
local cache_home = vim.fn.getenv("XDG_CACHE_HOME")
if cache_home == vim.NIL or cache_home == "" then
    cache_home = vim.fn.expand("$HOME/.cache")
end
vim.opt.undodir = cache_home .. "/nvim/undodir"
o.undofile = true -- persistent undo

o.hlsearch = false -- highlight search results
o.incsearch = true
o.smartcase = true -- override ignorecase if search contains uppercase
o.ignorecase = true -- use \X for capital

o.scrolloff = 16 -- keep 16 lines above and below cursor
o.isfname:append("@-@") -- allow @ in filenames

o.updatetime = 50 -- decrease trigger idle events to 50ms
o.timeoutlen = 300 -- decrease mapped sequence wait time

o.colorcolumn = "120" -- ruler column

o.inccommand = "split" -- live preview of :s

o.mouse = "a" -- enable mouse support

o.shada = { "'10", "<0", "s10", "h" } -- SHAredDAta - persistent command history and etc.

o.formatoptions:remove("o") -- don't have 'o' add a comment

-- set how to display certain whitespace characters in the editor
o.list = true
o.listchars = { tab = "» ", --[[trail = "·",--]] nbsp = "␣" }

o.cursorline = true -- highlight cursor line
