return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      for name, sign in pairs(YukiVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
      local dap = require("dap")
      dap.configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Remote",
          hostName = "127.0.0.1",
          port = 5005,
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>dp", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out", },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over", },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into", },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue", },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate", },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL", },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.after.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI", },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "x" }, },
    },
  },
}
