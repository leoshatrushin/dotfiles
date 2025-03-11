return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")

            require("dapui").setup()
            -- require("dap-go").setup()

            -- Handled by nvim-dap-go
            -- dap.adapters.go = {
            --   type = "server",
            --   port = "${port}",
            --   executable = {
            --     command = "dlv",
            --     args = { "dap", "-l", "127.0.0.1:${port}" },
            --   },
            -- }

            dap.adapters.gdb = {
                type = "executable",
                command = "x86_64-elf-gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.configurations.asm = {
                {
                    name = "Attach to gdbserver :1234",
                    type = "gdb",
                    request = "attach",
                    target = "localhost:1234",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                },
            }

            dap.configurations.c = {
                -- {
                --     name = "Launch",
                --     type = "gdb",
                --     request = "launch",
                --     program = function()
                --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                --     end,
                --     cwd = "${workspaceFolder}",
                --     stopAtBeginningOfMainSubprogram = false,
                -- },
                -- {
                --     name = "Select and attach to process",
                --     type = "gdb",
                --     request = "attach",
                --     program = function()
                --         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                --     end,
                --     pid = function()
                --         local name = vim.fn.input('Executable name (filter): ')
                --         return require("dap.utils").pick_process({ filter = name })
                --     end,
                --     cwd = '${workspaceFolder}'
                -- },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'gdb',
                    request = 'attach',
                    target = 'localhost:1234',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}'
                },
            }

            --[[
            local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
            if elixir_ls_debugger ~= "" then
                dap.adapters.mix_task = {
                    type = "executable",
                    command = elixir_ls_debugger,
                }

                dap.configurations.elixir = {
                    {
                        type = "mix_task",
                        name = "phoenix server",
                        task = "phx.server",
                        request = "launch",
                        projectDir = "${workspaceFolder}",
                        exitAfterTaskReturns = false,
                        debugAutoInterpretAllModules = false,
                    },
                }
            end
            --]]

            require("dap-python").setup("./venv/bin/python3")

            local cached_args = nil

            dap.configurations.python = {
                {
                    type = 'python';
                    request = 'launch';
                    name = "Launch file";
                    program = "${file}";
                    args = function()
                        if cached_args then
                            local input = vim.fn.input('Args: ', table.concat(cached_args, " "))
                            cached_args = vim.split(input, " ")
                        else
                            local input = vim.fn.input('Args: ')
                            cached_args = vim.split(input, " ")
                        end
                        return cached_args
                    end;
                },
            }

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<S-Enter>", dap.run_to_cursor)
            -- eval expression under cursor
            vim.keymap.set("n", "<leader>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<Enter>", dap.continue)
            vim.keymap.set("n", "<Down>", dap.step_into)
            vim.keymap.set("n", "<Up>", dap.step_over)
            vim.keymap.set("n", "<Tab>", dap.step_out)
            vim.keymap.set("n", "<M-Up>", dap.step_back)
            vim.keymap.set("n", "<leader>g", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
