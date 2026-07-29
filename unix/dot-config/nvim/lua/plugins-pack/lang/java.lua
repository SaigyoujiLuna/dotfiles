if vim.g.vscode then
  return
end

vim.lsp.enable("jdtls", false)

local cmd = { vim.fn.exepath("jdtls") }
local jdtls_config_dir = function(project_name)
  return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
end

local jdtls_workspace_dir = function(project_name)
  return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
end
local project_name = function(root_dir)
  return root_dir and vim.fs.basename(root_dir)
end
local root_dir = function(path)
  return vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
end
local full_cmd = function()
  local fname = vim.api.nvim_buf_get_name(0)
  local project_nm = project_name(root_dir(fname))
  local temp_cmd = vim.deepcopy(cmd)
  if project_nm then
    vim.list_extend(
      temp_cmd,
      { "-configuration", jdtls_config_dir(project_nm), "-data", jdtls_workspace_dir(project_nm) }
    )
  end
  return temp_cmd
end
local bundles = vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*jar", false, true)
vim.list_extend(bundles, vim.fn.glob("$MASON/share/java-test/*.jar", false, true))
local function attach_jdtls()
  local fname = vim.api.nvim_buf_get_name(0)
  local config = {
    cmd = full_cmd(),
    root_dir = root_dir(fname),
    init_options = {
      bundles = bundles,
    },
    settings = {
      java = {
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },
      },
    },
    capabilities = require("blink-cmp").get_lsp_capabilities(),
  }
  require("jdtls").start_or_attach(config)
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = attach_jdtls,
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local buf = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil or client.name ~= "jdtls" then
      return
    end

    local wk = require("which-key")
    require("jdtls.dap").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
    require("jdtls.dap").setup_dap_main_class_configs({})
    wk.add({
      mode = "n",
      buffer = ev.buf,
      {
        "<leader>tt",
        function()
          require("jdtls.dap").test_class()
        end,
        desc = "Run All Test",
      },
      {
        "<leader>tr",
        function()
          require("jdtls.dap").test_nearest_method()
        end,
        desc = "Run Nearest Test",
      },
      { "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
    })
  end,
})
