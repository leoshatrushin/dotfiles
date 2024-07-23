return {
    {
        "stevearc/conform.nvim",
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ timeout_ms = 500, lsp_fallback = true, quiet = false })
                end,
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            log_level = vim.log.levels.WARN,
            notify_on_error = true,
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" }, -- can have multiple formatters
                javascript = { { "prettierd", "prettier" } }, -- only run the first formatter found
            },
            format_on_save = function(bufnr)
                -- Disable "format_on_save lsp_fallback" for languages that don't
                -- have a well standardized coding style. You can add additional
                -- languages here or re-enable it for the disabled ones.
                local disable_filetypes = { c = true, cpp = true }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                    quiet = false,
                }
            end,
        },
    },
}
