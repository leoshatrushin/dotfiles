local M = {}

local function goToSeparator()
    local line = vim.api.nvim_get_current_line()

    local colon_col = string.find(line, ":") or string.find(line, "=")
    if colon_col == nil then
        return
    end

    vim.api.nvim_win_set_cursor(0, { vim.fn.line("."), colon_col - 1 })

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
    local diagnostics = vim.diagnostic.get(0, { lnum = line })
    if #diagnostics == 0 then
        return
    end

    local diagnostic_message = diagnostics[1].message
    vim.fn.setreg("+", diagnostic_message)
end

function M.smartRun()
    vim.api.nvim_command("silent w")

    local filename = vim.fn.expand("%")
    local basefilename = vim.fn.expand("%:r")
    local filetype = vim.bo.filetype
    local state_home = vim.fn.getenv("XDG_STATE_HOME") or vim.fn.expand("$HOME/.local/state")
    local outfile = state_home .. "/nvim/run.out"

    local cmd
    if filetype == "lua" then
        cmd = "lua " .. filename
    elseif filetype == "python" then
        cmd = "python3 " .. filename
    elseif filetype == "javascript" then
        cmd = "node " .. filename
    elseif filetype == "typescript" then
        cmd = "ts-node " .. filename
    elseif filetype == "c" or filetype == "cpp" then
        local compiler = filetype == "c" and "gcc" or "g++"
        cmd = string.format("%s %s -o %s && %s", compiler, filename, basefilename, basefilename)
    elseif filetype == "java" then
        -- Get the full path of the current file
        local fullpath = vim.fn.expand("%:p")
        -- Extract the root directory name (assumed to be the parent of 'src')
        local rootdirname = fullpath:match("(.+)/src/.+%.java$")
        -- Define the output directory based on the root directory name
        local outdir = string.format("%s/out/production/%s", rootdirname, rootdirname:match(".+/(.+)$"))
        -- Command to compile the Java file, specifying the output directory
        local compile_cmd = string.format("javac -d %s %s", outdir, fullpath)
        -- Command to run the compiled Java program
        -- Note: This assumes no package structure. If there's a package, you need to prepend it to the class name
        local run_cmd = string.format("java -cp %s %s", outdir, vim.fn.expand("%:t:r"))
        -- Combine compile and run commands
        cmd = compile_cmd .. " && " .. run_cmd
    end

    local redirect = " 2>&1 | tee " .. outfile
    cmd = cmd .. redirect
    local output = vim.fn.system(cmd)
    output = output:gsub("\n$", "")
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
