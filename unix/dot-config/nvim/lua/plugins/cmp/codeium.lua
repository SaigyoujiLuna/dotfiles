return {
  {
    "Exafunction/windsurf.nvim",
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enabled_cmp_source = false,
      idle_delay = 75,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = false
        },
      },
    },
    config = function(_, opts)
      YukiVim.cmp.actions.ai_accept = function()
        if require("codeium.virtual_text").get_current_completion_item() then
          vim.api.nvim_input(require("codeium.virtual_text").accept())
          return true
        end
      end
      require("codeium").setup(opts)
    end
  },
}
