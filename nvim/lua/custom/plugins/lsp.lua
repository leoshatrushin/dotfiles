return {
    {
        -- See :help lsp-vs-treesitter
        -- community-contributed default configurations for LSP servers
        -- 1) initialization command
        --     'php' ftplugin executes vim.lsp.start() with cmd 'intelephense --stdio',
        --     in root dir found by function, with default settings
        -- 2) set up diagnostic options using vim.diagnostic.config()
        -- 3) set up :LspX shortcuts, e.g. :LspInfo for vim.lsp.get_log_path()
        "neovim/nvim-lspconfig",
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            -- Useful status updates for LSP.
            { "j-hui/fidget.nvim", opts = {} },
            -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
            -- used for completion, annotations and signatures of Neovim apis
            "folke/neodev.nvim",
            -- Schema information
            "b0o/SchemaStore.nvim",
            "Issafalcon/lsp-overloads.nvim", -- lsp view all overloads and signatures
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    -- telescope.builtin.definitions/references/lsp_type_definitions?
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.signatureHelpProvider then
                        require("lsp-overloads").setup(client, {
                            keymaps = {
                                previous_signature = "<M-i>",
                                next_signature = "<M-o>",
                                previous_parameter = "<M-j>",
                                next_parameter = "<M-k>",
                                close_signature = "<M-b>",
                            },
                            display_automatically = true,
                        })
                    end

                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        vim.keymap.set("n", "<leader>yh", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end, { buffer = 0, desc = "LSP: [T]oggle Inlay [H]ints" })
                    end
                end,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            local custom_configs = {
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    settings = {
                        -- You must disable built-in schemaStore support if you want to use
                        -- this plugin and its advanced options like `ignore`.
                        enable = false,
                        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                        url = "",
                    },
                },
                clangd = {
                    cmd = {
                        string.find(vim.fn.getcwd(), "/esp")
                                and vim.fn.expand("$HOME") .. "/devtools/esp-clang/bin/clangd"
                            or "clangd",
                        "--background-index",
                        "--pch-storage=memory",
                        "--clang-tidy",
                        "--suggest-missing-includes",
                        "--cross-file-rename",
                        "--completion-style=detailed",
                        "--header-insertion=iwyu",
                    },
                    init_options = {
                        clangdFileStatus = true,
                        usePlaceholders = true,
                        completeUnimported = true,
                        semanticHighlighting = true,
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                -- Tell the language server which version of Lua you're using
                                -- (most likely LuaJIT in the case of Neovim)
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = {
                                    'vim',
                                    'require'
                                },
                            },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                kotlin_language_server = {
                    root_dir = function() return "/Users/leoshatrushin/dev/experiments" end,
                },
                -- https://github.com/pmizio/typescript-tools.nvim?
            }

            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server)
                        local config = custom_configs[server] or {}
                        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
                        lspconfig[server].setup(config)
                    end,
                },
            })
        end,
    },
}
