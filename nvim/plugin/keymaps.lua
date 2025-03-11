local M = {}

M.Editing = {
    { {"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" } }, -- asbjornHaland
    { "n", "<leader>Y", [[gg"+yG]], { desc = "Yank file to system clipboard" } },
    { "x", "<leader>p", [["_dP]], { desc = "Paste without yank" } },
    { {"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without yank" } },
    { "v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines up" } },
    { "v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines down" } },
    { "n", "J", "mzJ`z", { desc = "Stay at current position when contatenating next line" } },
    { "n", "M", "$mzT,i<CR><Esc>0`z", { desc = "Comma-delimited inverse of J" } },
    { "n", "ck", "<cmd>lua require('helpers').smart_change('key')<CR>" },
    { "n", "cv", "<cmd>lua require('helpers').smart_change('value')<CR>" },
    { "v", "<", "<gv", { desc = "Reselect on indent left" } },
    { "v", ">", ">gv", { desc = "Reselect on indent right" } },
    { "n", "<M-s>", "<cmd>w<CR>" },
    { "n", "<M-r>", "<C-r>" },
}

M.Navigation = {
    { { "n", "v", "o" }, "H", "^", { desc = "Move to end of line" } },
    { { "n", "v", "o" }, "L", "$", { desc = "Move to start of line" } },
    { "n", "<leader>eo", vim.diagnostic.open_float, { desc = "[O]pen diagnostic [E]rror messages" } },
    { "n", "<leader>ec", '<cmd>lua require("helpers").copy_diagnostic_to_clipboard()<CR>' },
    { "n", "n", "nzzzv", { desc = "Re-center and open any folds on [n]ext" } },
    { "n", "N", "Nzzzv", { desc = "Re-center and open any folds on [N]ext" } },
    { "n", "<M-u>", "<C-u>zz", { desc = "Re-center on page up" } },
    { "n", "<M-d>", "<C-d>zz", { desc = "Re-center on page down" } },
    { "n", "<M-n>", "<cmd>cnext<CR>zz" },
    { "n", "<C-S-m>", "<cmd>cprev<CR>zz" },
    { "n", "<M-i>", "<C-i>" },
    { "n", "<M-o>", "<C-o>" },
    { "n", "<M-p>", "<C-w>" },
}

M.Helpers = {
    { "n", "<leader>r", "<cmd>lua require('helpers').smartRun()<CR>" },
    { "n", "<leader>o", "<cmd>e ~/.local/state/nvim/run.out<CR>" },
    { "n", "<leader>c", "<cmd>silent !cat ~/.local/state/nvim/run.out | pbcopy<CR>" },
    { "n", "<leader>x", "<cmd>silent !chmod +x %<CR>" },
    { "n", "<leader>i", "<cmd>G<CR>" },
    { "n", "<leader>l", "<cmd>G log<CR>" },
    { "n", "<leader><CR>", "<cmd>source %<CR>" },
    { "n", "<leader>q", "<cmd>lua require('helpers').smart_quit()<CR>" },
    { "n", "<leader>m", function() vim.cmd("silent !tmux neww man " .. vim.fn.expand("<cword>")) end },
    { "n", "<leader>2m", function() vim.cmd("silent !tmux neww man 2 " .. vim.fn.expand("<cword>")) end },
    { "n", "<leader>3m", function() vim.cmd("silent !tmux neww man 3 " .. vim.fn.expand("<cword>")) end },
}

vim.opt.runtimepath:append("~/.config/nvim/plugin")

for _, group in pairs(M) do
    for _, mapping in pairs(group) do
        vim.keymap.set(unpack(mapping))
    end
end

vim.keymap.set("n", "<M-b>", "<cmd>LspOverloadsSignature<CR>")
vim.keymap.set("i", "<M-b>", "<cmd>LspOverloadsSignature<CR>")

vim.keymap.set("n", "<C-S-a>o", "<cmd>colorscheme rose-pine<CR>")
vim.keymap.set("n", "<C-S-a>t", function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end)

vim.keymap.set("n", "<M-]>", "<C-]>")

-- vim.keymap.set("n", "o", "0o")
-- vim.keymap.set("n", "O", "0O")
-- suggestion - fff to ggVG=
