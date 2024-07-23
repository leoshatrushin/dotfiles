return {
    {
        "numToStr/Comment.nvim", -- "gc/b [+c/boOA or motion]" to comment
        -- dependencies = { {"JoosepAlviste/nvim-ts-context-commentstring", config = function()
        --     require('ts_context_commentstring').setup({
        --         enable_autocmd = false,
        --     })
        -- }, -- support for jsx/tsx
        -- opts = {
        --     pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        --     -- `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
        --     -- `gbac` - Toggle comment around a class (w/ LSP/treesitter support)
        -- },
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        -- See `:help gitsigns` to understand what the configuration keys do
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    { -- Highlight todo, notes, etc in comments
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = true },
    },
    { -- color hex colors
        "chrisbra/Colorizer",
        config = function()
            vim.g.colorizer_auto_filetype = "css,html,js,jsx,ts,tsx"
            vim.g.colorizer_disable_bufleave = 1

            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { "*.css", "*.html", "*.htm", "*.js", "*.jsx", "*.ts", "*.tsx" },
                command = "ColorHighlight!",
            })
        end,
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    "tpope/vim-sleuth", -- detect tabstop and shiftwidth automatically
    "tpope/vim-fugitive", -- git plugin
    "github/copilot.vim",
    "mattn/emmet-vim", -- htlm:5
    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    -- "windwp/nvim-ts-autotag", -- auto close html tags
    { -- gx to open url
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browser<cr>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true, -- default settings
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },
    --"prisma/vim-prisma",
    --{'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    --'jose-elias-alvarez/null-ls.nvim',
    --'lervag/vimtex',
}
