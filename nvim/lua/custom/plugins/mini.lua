return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup() -- better around/inside textobjects, e.g. yinq (next ')
            require("mini.surround").setup() -- surround keymaps
            --local statusline = require 'mini.statusline'
            --statusline.setup { use_icons = vim.g.have_nerd_font }
        end,
    },
}
