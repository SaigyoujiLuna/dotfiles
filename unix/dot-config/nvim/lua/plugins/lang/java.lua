-- Utility function to extend or override a config table, similar to the way
-- that Plugin.opts works.
---@param config table
---@param custom function | table | nil
local function extend_or_override(config, custom, ...)
  if type(custom) == "function" then
    config = custom(config, ...) or config
  elseif custom then
    config = vim.tbl_deep_extend("force", config, custom) --[[@as table]]
  end
  return config
end
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    cond = not vim.g.vscode,
    opts = function()
      local cmd = { vim.fn.exepath("jdtls") }
      -- local lombok_jar = vim.fn.expand("$MASON/share/jdtls/lombok.jar")
      -- table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))

      return {
        root_dir = function(path)
          return vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
        end,
        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,
        jdtls_config_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
        end,
        jdtls_workspace_dir = function(project_name)
          return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
        end,
        cmd = cmd,
        full_cmd = function(opts)
          local fname = vim.api.nvim_buf_get_name(0)
          local root_dir = opts.root_dir(fname)
          local project_name = opts.project_name(root_dir)
          local temp_cmd = vim.deepcopy(opts.cmd)
          if project_name then
            vim.list_extend(
              temp_cmd,
              { "-configuration", opts.jdtls_config_dir(project_name), "-data", opts.jdtls_workspace_dir(project_name) }
            )
          end
          return temp_cmd
        end,
        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
        settings = {
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
            home = "/opt/homebrew/opt/openjdk",
          },
        },
      }
    end,
    config = function(_, opts)
      local bundles = {} ---@type string[]
      if opts.dap then
        bundles = vim.fn.glob("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*jar", false, true)
        if opts.test then
          vim.list_extend(bundles, vim.fn.glob("$MASON/share/java-test/*.jar", false, true))
        end
      end
      local function attach_jdtls()
        local fname = vim.api.nvim_buf_get_name(0)
        local config = extend_or_override({
          cmd = opts.full_cmd(opts),
          root_dir = opts.root_dir(fname),
          init_options = {
            bundles = bundles,
          },
          settings = opts.settings,
          capabilities = require("blink-cmp").get_lsp_capabilities(),
        }, opts.jdtls)
        require("jdtls").start_or_attach(config)
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        callback = attach_jdtls,
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local wk = require("which-key")
          if opts.dap then
            require("jdtls.dap").setup_dap(opts.dap)
            if opts.dap_main then
              require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
            end
            if opts.test then
              wk.add({
                mode = "n",
                buffer = args.buf,
                {
                  "<leader>tt",
                  function()
                    require("jdtls.dap").test_class({
                      config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                    })
                  end,
                  desc = "Run All Test",
                },
                {
                  "<leader>tr",
                  function()
                    require("jdtls.dap").test_nearest_method({
                      config_overrides = type(opts.test) ~= "boolean" and opts.test.config_overrides or nil,
                    })
                  end,
                  desc = "Run Nearest Test",
                },
                { "<leader>tT", require("jdtls.dap").pick_test, desc = "Run Test" },
              })
            end
          end
        end,
      })
      attach_jdtls()
    end,
  },
}
