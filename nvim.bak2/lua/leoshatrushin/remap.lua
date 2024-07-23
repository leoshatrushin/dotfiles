vim.g.mapleader = " "

vim.keymap.set("n", "ck", [[<Cmd>lua require('leoshatrushin.functions').smart_change('key')<CR>]])
vim.keymap.set("n", "cv", [[<Cmd>lua require('leoshatrushin.functions').smart_change('value')<CR>]])

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "o", "0o")
vim.keymap.set("n", "O", "0O")

vim.keymap.set("n", "Q", [[<Cmd>lua require('leoshatrushin.functions').smart_quit()<CR>]])

vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "L", "$")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "M", "$mzT,i<CR><Esc>0`z")

vim.keymap.set('n', '<leader>eo', '<cmd>lua vim.diagnostic.open_float()<CR>')
-- The following command requires plug-ins "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", and optionally "kyazdani42/nvim-web-devicons" for icon support
vim.keymap.set('n', '<leader>ee', '<cmd>Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>ec', '<cmd>lua require("leoshatrushin.functions").copy_diagnostic_to_clipboard()<CR>')
-- If you don't want to use the telescope plug-in but still want to see all the errors/warnings, comment out the telescope line and uncomment this:
-- vim.keymap.set('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>')

vim.keymap.set("n", "<leader>r", [[<Cmd>lua require('leoshatrushin.functions').smartRun()<CR>]])
vim.keymap.set("n", "<leader>z", ':e ~/tmp<CR>')

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [[gg"+yG]])

vim.keymap.set("n", "<leader>ik", "<cmd>set tabstop+=2|set softtabstop+=2<CR>:set shiftwidth+=2<CR>")
vim.keymap.set("n", "<leader>ij", "<cmd>set tabstop-=2|set softtabstop-=2<CR>:set shiftwidth-=2<CR>")

vim.keymap.set("n", "2o", "o<CR>")
vim.keymap.set("n", "2O", "O<Esc>O")
vim.keymap.set("n", "3o", "o<CR><CR><Esc>kS")
vim.keymap.set("n", "3O", "O<CR><CR><Esc>kS")
vim.keymap.set("n", "<leader>o", "o<CR><Esc>kS")
vim.keymap.set("n", "<leader>O", "O<CR><Esc>kS")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<leader><CR>", ":lua Reload(\"leoshatrushin\")<CR>")
vim.keymap.set("n", "<leader>p<CR>", "<cmd>so ~/.config/nvim/lua/leoshatrushin/packer.lua | PackerSync<CR>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- vim.api.nvim_set_keymap("n", "<leader>S", ":ASToggle<CR>", {})

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>x", ":silent !chmod +x %<CR>")

vim.keymap.set("n", "<leader>c", ":silent !cat ~/.local/state/nvim/run.out | pbcopy<CR>")

-- vim.keymap.set("n", "<leader>gce", ":Copilot enable<CR>")
-- vim.keymap.set("n", "<leader>gcd", ":Copilot disable<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>G<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>G log<CR>")

vim.keymap.set("n", "<leader>m", function() vim.cmd('silent !tmux neww man ' .. vim.fn.expand('<cword>')) end)

vim.keymap.set("n", "<M-b>", "<cmd>LspOverloadsSignature<CR>")
vim.keymap.set("i", "<M-b>", "<cmd>LspOverloadsSignature<CR>")

vim.keymap.set("n", "<M-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-m>", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<C-S-a>o", "<cmd>colorscheme rose-pine<CR>")
vim.keymap.set("n", "<C-S-a>t", function() vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }) end)

vim.keymap.set("n", "<M-r>", "<C-r>")
vim.keymap.set("n", "<M-u>", "<C-u>zz")
vim.keymap.set("n", "<M-i>", "<C-i>")
vim.keymap.set("n", "<M-o>", "<C-o>")
vim.keymap.set("n", "<M-p>", "<C-w>")
vim.keymap.set("n", "<M-]>", "<C-]>")
-- vim.keymap.set("i", "<M-]>", function()
--     local cmp = require("cmp")
--     cmp.select_next_item()
--     cmp.complete()
-- end)
vim.keymap.set("n", "<M-s>", "<cmd>w<CR>")
vim.keymap.set("n", "<M-d>", "<C-d>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
