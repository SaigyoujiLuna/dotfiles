return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/fixcursorhold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "mrcjkb/rustaceanvim",
    "nvim-neotest/nvim-nio",
  },
  opts = function()
    return {adapters = {
      require("rustaceanvim.neotest"),
    },
    status = { virtual_text = true, enabled = true },

  }end,
  config = function(opts)
    local keymap = vim.keymap.set

    local loaded = false

    local function load_neotest()
      if loaded then
        return
      end
      require("neotest").setup(opts)
    end
    keymap({ "n" }, "<leader>t", "", { desc = "+test" })
    -- stylua: ignore
    keymap({ "n" }, "<leader>ta", function() load_neotest();require("neotest").run.attach() end, { desc = "Attach to Test" })
    -- stylua: ignore
    keymap({ "n" }, "<leader>td", function() load_neotest(); require("neotest").run.run({ strategy = "dap", suite = true }) end, { desc = "Run Nearest Debug" })
    -- stylua: ignore
    keymap( { "n", }, "<leader>tr", function() load_neotest(); require("neotest").run.run() end, { desc = "Run Nearest (Neotest)" })
    -- stylua: ignore
    keymap({ "n" }, "<leader>tu", function() load_neotest(); require("neotest").output() end, { desc = "Test Output (Neotest)" })
  end,
}
