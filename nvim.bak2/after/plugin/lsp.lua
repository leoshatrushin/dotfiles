local lsp = require('lsp-zero').preset({
	manage_nvim_cmp = {
		set_sources = 'recommended'
	}
})

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}
require('lspconfig').yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

local current_classpath = vim.fn.getenv("CLASSPATH")
if current_classpath and current_classpath ~= vim.NIL then
    current_classpath = "./lib/mojo/parse" .. current_classpath
end
require('lspconfig').jdtls.setup{
    root_dir = function()
        return vim.fn.getcwd()
    end
}
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, {
  offsetEncoding = { 'utf-16' },
  general = {
    positionalEncodings = { 'utf-16' },
  },
})

local clangd_bin = 'clangd'
local ESP_dirs = {
    [vim.fn.expand('$HOME') .. '/dev/EnergyGraphs'] = true,
    [vim.fn.expand('$HOME') .. '/dev/EnergyMonitor/esp'] = true,
    [vim.fn.expand('$HOME') .. '/dev/AirconButton/esp'] = true,
}
local esp_dir = vim.fn.expand('$HOME') .. '/esp'
if ESP_dirs[vim.fn.getcwd()] or string.sub(vim.fn.getcwd(), 1, string.len(esp_dir)) == esp_dir then
    clangd_bin = vim.fn.expand('$HOME') .. '/devtools/esp-clang/bin/clangd'
end

require('lspconfig').clangd.setup{
  capabilities = capabilities,
	cmd = {
		clangd_bin,
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
}

-- Set preferences
lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

-- Setup default keymaps
lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>a", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    --- Guard against servers without the signatureHelper capability
    if client.server_capabilities.signatureHelpProvider then
        require('lsp-overloads').setup(client, {
			keymaps = {
                previous_signature = "<M-i>",
				next_signature = "<M-o>",
                previous_parameter = "<M-j>",
				next_parameter = "<M-k>",
				close_signature = "<M-b>"
			},
			display_automatically = false,
		})
    end
end)

-- Finalize lsp setup
lsp.setup()

local cmp = require('cmp')

cmp.setup({
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<M-\\>'] = cmp.mapping.complete(),
      ['<esc>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.close()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, true, true), 'n', true)
        else
            fallback()
        end
    end, { 'i', 's', 'c' }),
      -- ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Up>'] = cmp.mapping.confirm({ select = false }),

      -- Navigate between snippet placeholder
      -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

      ['<M-[>'] = cmp.mapping.select_prev_item(),
      ['<M-]>'] = cmp.mapping.select_next_item(),

      ['<C-q>'] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'cmp_tabnine' },
      { name = 'nvim_lsp_signature_help'},
      { name = 'nvim_lua' },
      { name = 'async_path'},
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
