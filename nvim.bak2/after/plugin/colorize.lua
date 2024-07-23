vim.g.colorizer_auto_filetype = 'css,html,js,jsx,ts,tsx'
vim.g.colorizer_disable_bufleave = 1
vim.api.nvim_exec([[
  au BufNewFile,BufRead *.css,*.html,*.htm,*.js,*.jsx,*.ts,*.tsx  :ColorHighlight!
]], false)
require("rose-pine").setup({
    styles = {
        italic = false
    }
})
