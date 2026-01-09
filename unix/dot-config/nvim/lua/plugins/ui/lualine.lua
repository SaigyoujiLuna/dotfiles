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
            statusline = { "NvimTree", "neo-tree", "netrw", "dashboard" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "filename", "diagnostics" },
          lualine_x = {
            Snacks.profiler.status(),
            {
              function()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                  return ""
                else
                  return "󰑋 " .. recording_register
                end
              end,
              separator = { left = "", right = "" },
              color = { fg = "#333333", bg = require("catppuccin.palettes").get_palette("macchiato").red },
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
