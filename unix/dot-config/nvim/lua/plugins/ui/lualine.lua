return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/snacks.nvim" },
    event = { "BufEnter" },
    opts = function()
      return {
        options = {
          icons_enabled = true,
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = {
            statusline = { "neo-tree", "netrw", "dashboard" },
          },
          -- sections = {
          -- 	lualine_a = "mode",
          -- 	lualine_b = { "branch"},
          --
          -- }
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename", "diagnostics" },
          lualine_x = {
            Snacks.profiler.status(),
            {
              function()
                ---@type NoiceStatus
                return require("noice").api.status.command.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.command.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Statement") }
              end,
            },
            {
              function()
                return require("noice").api.status.mode.get()
              end,
              cond = function()
                return package.loaded["noice"] and require("noice").api.status.mode.has()
              end,
              color = function()
                return { fg = Snacks.util.color("Constant") }
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }
    end,
  },
}
