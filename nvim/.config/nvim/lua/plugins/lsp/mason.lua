return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_enable = false,
      ensure_installed = {
        "pyright",
        "lua_ls",
        "ts_ls",
        "html",
        "cssls",
        "emmet_language_server",
        "bashls",
        "rust_analyzer",
        "tailwindcss",
        "clangd",
        -- "ruff", <-- removed because pipx manages it
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "stylua",
        "prettier",
        "clang-format",
        "djlint",
        "shfmt",
        -- "mypy", <-- removed because pipx manages it
        -- "ruff", <-- removed because pipx manages it
      },
    })
  end,
}
