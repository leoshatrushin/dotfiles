local M = {}

local function goToSeparator()
    local line = vim.api.nvim_get_current_line()
    local colon_col = string.find(line, ":")
    if colon_col == nil then
        colon_col = string.find(line, "=")
    end
    if colon_col == nil then
        return
    end

    vim.api.nvim_win_set_cursor(0, {vim.fn.line("."), colon_col - 1})

    return colon_col
end

local function smartReplace(type)
    local line = vim.api.nvim_get_current_line()
    local word_col = vim.fn.col(".") + 1
    local char = string.sub(line, word_col, word_col)
    if type == "key" then
        vim.api.nvim_feedkeys("h", "n", false)
    end
    vim.notify(char)
    if char == '"' or char == "'" then
        vim.api.nvim_feedkeys("ci" .. char, "n", false)
    elseif type == "value" then
        local hasSemicolon = string.find(line, ";")
        local hasComma = string.find(line, ",")
        if hasSemicolon ~= nil then
            vim.api.nvim_feedkeys("ct;", "n", false)
        elseif hasComma ~= nil then
            vim.api.nvim_feedkeys("ct,", "n", false)
        else
            vim.api.nvim_feedkeys("ct$", "n", false)
        end
    else
        vim.api.nvim_feedkeys("llc^", "n", false)
    end
end

function M.smart_change(type)
    local colon_col = goToSeparator()
    if colon_col ~= nil then
        if type == "value" then
            vim.api.nvim_feedkeys("/[^ ]\n", "n", true)
        elseif type == "key" then
            vim.api.nvim_feedkeys("?[^ ]\n", "n", true)
        end
        smartReplace(type)
    end
end

function M.copy_diagnostic_to_clipboard()
    local line = vim.fn.line(".") - 1
    local diagnostics = vim.diagnostic.get(0, {lnum = line})

    if #diagnostics == 0 then
        return
    end

    local diagnostic_message = diagnostics[1].message
    vim.fn.setreg("+", diagnostic_message)
end

function M.smartRun()
    vim.api.nvim_command("silent w")
    local filetype = vim.bo.filetype
    local state_home = vim.fn.getenv("XDG_STATE_HOME") or vim.fn.expand("$HOME/.local/state")
    local outfile = state_home .. "/nvim/run.out"
    local redirect = " 2>&1 | tee " .. outfile
    local cmd
    if filetype == "javascript" then
        cmd = "node " .. vim.fn.expand("%")
    elseif filetype == "typescript" then
        cmd = "ts-node " .. vim.fn.expand("%")
    elseif filetype == "c" then
        local filepathModifier = ""
        if not string.find(vim.fn.expand("%"), "/") then
            filepathModifier = "./"
        end
        cmd = "gcc " .. vim.fn.expand("%") .. " -o " .. vim.fn.expand("%:r")
            .. " && " .. filepathModifier .. vim.fn.expand("%:r")
    elseif filetype == "lua" then
        cmd = "lua " .. vim.fn.expand("%")
    elseif filetype == "python" then
        cmd = "python3 " .. vim.fn.expand("%")
	elseif filetype == "java" then
		cmd = "javac " .. vim.fn.expand("%") .. "&& java " .. vim.fn.expand("%:r")
    end
    cmd = cmd .. redirect
    local output = vim.fn.system(cmd)
    if string.sub(output, #output, #output) == "\n" then
        output = string.sub(output, 1, #output - 1)
    end
    print(output)
end

function M.smart_quit()
    if vim.bo.modified then
        vim.api.nvim_command("silent wq")
    else
        vim.api.nvim_command("silent q")
    end
end

return M
