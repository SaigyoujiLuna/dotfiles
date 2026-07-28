if vim.g.vscode then
    return;
end
require("plugins-pack.lang.lsp")
require("plugins-pack.lang.clangd")
require("plugins-pack.lang.d2")
require("plugins-pack.lang.java")
require("plugins-pack.lang.markdown")
require("plugins-pack.lang.python")
require("plugins-pack.lang.rust")
require("plugins-pack.lang.typescript")
