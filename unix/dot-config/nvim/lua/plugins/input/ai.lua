require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = {
        name = "opencode",
        model = "opencode/gpt-5.6-luna",
      },
    },
    inline = {
      adapter = "opencode",
    },
    cmd = {
      adapter = "opencode",
    },
    cli = {
      agent = "opencode",
      agents = {
        opencode = {
          cmd = "opencode",
          args = {},
          description = "OpenCode",
          provider = "terminal",
        },
      },
    },
  },
})

require("supermaven-nvim").setup({
  disable_inline_suggestion = false,
  disable_keymaps = true,
  ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
})
YukiVim.cmp.actions.ai_accept = function()
  local suggestion = require("supermaven-nvim.completion_preview")
  if suggestion.has_suggestion() then
    suggestion.on_accept_suggestion()
    return true
  end
  return false
end
