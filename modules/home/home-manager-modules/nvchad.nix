{ config, pkgs, nvchadModule, ... }: 
{
  imports = [
    nvchadModule
  ];
  
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      # nodePackages.bash-language-server
      # docker-compose-language-service
      # dockerfile-language-server-nodejs
      # emmet-language-server
      tree-sitter
      tree-sitter-grammars.tree-sitter-python
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-lua
      lua-language-server
      fzf
      nixd
      ripgrep
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-python
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
        debugpy
        ruff
        black
        mypy
      ]))
    ];
    hm-activation = true;
    backup = true;
    extraPlugins = ''
  return {
    {
      "nvim-neotest/nvim-nio",
    },
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "rcarriga/nvim-dap-ui",
      },
      config = function()
        local dap = require("dap")

        dap.adapters.python = {
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
        }

        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "''${file}",
            pythonPath = function()
              -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
              -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
              -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                return cwd .. '/venv/bin/python'
              elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                return cwd .. '/.venv/bin/python'
              elseif vim.fn.executable("python") == 1 then
                return vim.fn.exepath("python")
              else -- WARNING cfg.dap.package probably has NO libraries other than builtins and debugpy
                return "''${getExe cfg.dap.package}"
              end
            end,
          },
        }

        -- Setup dap-ui (must be in same block)
        local dapui = require("dapui")
        dapui.setup()
        dap.defaults.fallback.terminal_win_cmd = '10split new'  -- persistent REPL
        require("dap").repl.open({}, "belowright split")         -- open REPL with session

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        -- dap.listeners.before.event_terminated["dapui_config"] = function()
        --   dapui.close()
        -- end
        -- dap.listeners.before.event_exited["dapui_config"] = function()
        --   dapui.close()
        -- end

        -- DAP keymaps
        vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>bb', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })

      -- DAP keymaps
--       vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
--       vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
--       vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
--       vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
--       vim.api.nvim_set_keymap('n', '<leader>bb', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<F5>", function()
if vim.tbl_isempty(dap.sessions()) then
  dap.continue()  -- start new session
  else
    dap.continue()  -- resume current
    end
    end, { desc = "Start/Continue Debug", noremap = true, silent = true })

vim.keymap.set("n", "<F10>", function()
dap.step_over()
end, { desc = "Step Over", noremap = true, silent = true })

vim.keymap.set("n", "<F11>", function()
dap.step_into()
end, { desc = "Step Into", noremap = true, silent = true })

vim.keymap.set("n", "<F12>", function()
dap.step_out()
end, { desc = "Step Out", noremap = true, silent = true })

vim.api.nvim_create_user_command("DebugStart", function()
dapui.open()
dap.continue()
end, {})

vim.api.nvim_create_user_command("DebugStop", function()
dap.terminate()
dapui.close()
end, {})

      end,
    },

    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = { "pyright" },
        })
        require("lspconfig").pyright.setup({})
      end,
    },

    {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
          sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.diagnostics.mypy,
          },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.py",
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end,
    },
  }
'';

  };
}