local M = {}
M.packages = {
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/thehamsta/nvim-dap-virtual-text",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
}

M.config = function()
  local dap = require("dap")
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
  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005,
    },
  }
  local keymap = vim.keymap.set
  -- stylua: ignore
  keymap( { "n" }, "<leader>dp", function() require("dap").toggle_breakpoint() end, {desc = "Toggle Breakpoint"} )
  -- stylua: ignore
  keymap({ "n" }, "<leader>do", function() require("dap").step_out() end, { desc = "Step Out" })
  --stylua: ignore
  keymap({ "n" }, "<leader>dO", function() require("dap").step_over() end, { desc = "Step Over" })
  --stylua: ignore
  keymap({ "n" }, "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
  --stylua: ignore
  keymap({ "n" }, "<leader>dc", function() require("dap").continue() end, { desc = "Continue" })
  --stylua: ignore
  keymap({ "n" }, "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate" })
  keymap({ "n" }, "<leader>dr", function()
    require("dap").repl.toggle()
  end, { desc = "Toggle REPL" })

  require("nvim-dap-virtual-text").setup({})

  local dapui = require("dapui")
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
  end
  dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
  end

  -- stylua: ignore
  keymap({ "n" }, "<leader>du", function() require("dapui").toggle() end, { desc = "Toggle UI" })
  -- stylua: ignore
  keymap({ "n", "x" }, "<leader>de", function() require("dapui").eval() end, { desc = "Eval" })
end
return M
