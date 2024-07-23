return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                styles = {
                    italic = false,
                },
            })
            vim.cmd.colorscheme("rose-pine")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
    "rktjmp/lush.nvim",
    "tckmn/hotdog.vim",
    "dundargoc/fakedonalds.nvim",
    "craftzdog/solarized-osaka.nvim",
    "eldritch-theme/eldritch.nvim",
    "jesseleite/nvim-noirbuddy",
    "vim-scripts/MountainDew.vim",
    "miikanissi/modus-themes.nvim",
    "rebelot/kanagawa.nvim",
    "gremble0/yellowbeans.nvim",
    "rockyzhang24/arctic.nvim",
    "folke/tokyonight.nvim",
    "Shatur/neovim-ayu",
    "RRethy/base16-nvim",
    "xero/miasma.nvim",
    "cocopon/iceberg.vim",
    "kepano/flexoki-neovim",
    "ntk148v/komau.vim",
    "uloco/bluloco.nvim",
    "LuRsT/austere.vim",
    "ricardoraposo/gruvbox-minor.nvim",
    "NTBBloodbath/sweetie.nvim",
    "maxmx03/fluoromachine.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    "morhetz/gruvbox",
    -- gruvbuddy
}
