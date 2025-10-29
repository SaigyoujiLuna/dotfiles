return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      animate = { enabled = true, duration = 300, easing = "linear", fps = 60 },
      bigfile = { enabled = true, notify = true, size = 3 * 1024 * 1024 },
      dashboard = { enabled = true },
      dim = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = false },
      lazygit = {
        configure = true,
      },
      notifier = {
        enabled = true,
        style = "compact",
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        config = function(opts)
          if opts.source == "explorer" then
            ---@type snacks.picker.explorer.Config
            local explorer_opts = opts
            explorer_opts.hidden = true
            explorer_opts.git_untracked = true
            explorer_opts.ignored = true
            return explorer_opts
          end
          return opts
        end,
      },
      quickfile = { enabled = true, win = {} },
      scope = { enabled = true },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
      },
      statuscolumn = {
        enabled = true,
      },
      words = { enabled = true },
      win = {
        border = "rounded",
        position = "float",
      },
      terminal = {
        enabled = true,
      },
      zen = {
        enabled = true,
      },
      toggle = {
        enabled = true,
        toggle = vim.keymap.set,
        which_key = true,
        notify = true,
        color = {
          enabled = "green",
          disabled = "yellow",
        },
        wk_desc = {
          enabled = "Disable ",
          disabled = "Enable ",
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)
      -- Snacks.dim.enable()
    end,
    keys = {
      {
        "<C-/>",
        function()
          require("snacks").terminal.toggle(nil, {
            win = {
              position = "float",
              border = "rounded",
            },
          })
        end,
        mode = { "i", "n", "t" },
        desc = "Toggle Terminal",
      },
      {
        "<C-_>",
        function()
          require("snacks").terminal.toggle()
        end,
        mode = { "i", "n", "t" },
        desc = "Toggle Terminal",
      },
      {
        "<leader>e",
        function()
          Snacks.picker.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git File Status",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader><Space>",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
    },
  },
}
