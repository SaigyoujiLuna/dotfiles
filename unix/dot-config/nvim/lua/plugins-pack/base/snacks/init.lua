local finder = require("plugins-pack.base.snacks.finder")
local styles = require("plugins-pack.base.snacks.style")
local keys = {}
if finder.opts.enabled then
  vim.list_extend(keys, finder.keys)
end
require("snacks").setup({
  animate = { enabled = true, duration = 300, easing = "linear", fps = 60 },
  bigfile = { enabled = true, notify = true, size = 3 * 1024 * 1024 },
  dashboard = { enabled = false },
  dim = { enabled = true },
  indent = { enabled = false },
  lazygit = {
    configure = true,
  },
  notifier = {
    enabled = false,
  },
  image = {
    enabled = true,
  },
  input = { enabled = true },
  picker = finder.opts,
  quickfile = { enabled = true, win = {} },
  scope = { enabled = true },
  styles = styles.opts,
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
})
vim.list_extend(keys, {
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
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit",
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
})
for _, key in ipairs(keys) do
  local lhs = key[1]
  local rhs = key[2]
  local desc = key.desc
  local mode = key.mode or "n"
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end
