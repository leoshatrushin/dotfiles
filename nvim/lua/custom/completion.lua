require("custom.snippets")

--vim.opt.completeopt = { "menu", "menuone", "noselect" }
--vim.opt.shortmess:append("c")

require("lspkind").init({})

local cmp = require("cmp")

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "async_path" },
    }, {
        { name = "buffer" }, -- cmp.config.sources helper deprioritises this
    }),
    -- no, but seriously. Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert({ -- helper uses auto-insert behaviour
        ["<M-]>"] = cmp.mapping.select_next_item(), -- karabiner remap of <M-Tab>
        ["<M-[>"] = cmp.mapping.select_prev_item(), -- karabiner remap of <M-S-Tab>
        ["<Up>"] = cmp.mapping.confirm({ select = true }), -- autoselects first item
        ["<C-q>"] = cmp.mapping.abort(),
        ["<esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.close()
            end
            fallback()
        end, { "i", "s", "c" }),
        ["<C-m>"] = cmp.mapping(function()
            local luasnip = require("luasnip")
            if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function()
            local luasnip = require("luasnip")
            if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            end
        end, { "i", "s" }),
        -- open, close, scroll docs
    }),
    -- enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline({ ":" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "async_path" },
    }, {
        { name = "cmdline" },
    }),
})
