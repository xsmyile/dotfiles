return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show documentation for what is under the cursor"
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded" })
        end, opts)

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP type definitions"
        vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "Show LSP references"
        vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show signature help"
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help({ border = "rounded" })
        end, opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        opts.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    vim.diagnostic.config({
      signs = false,
      float = {
        border = "rounded",
      },
    })

    vim.lsp.config.pyright = {
      capabilities = capabilities,
      settings = {
        pyright = {
          -- Using Ruff's import organizer
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            typeCheckingMode = "off", -- Turn off type checking (using mypy instead)
            diagnosticMode = "openFilesOnly", -- Only analyze open files
            useLibraryCodeForTypes = true, -- Still use library types for completion
          },
        },
      },
    }

    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    }

    vim.lsp.config.tailwindcss = {
      capabilities = capabilities,
      filetypes = { "html", "css", "javascript", "typescript", "svelte", "vue" },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = { "tw`([^`]*)`", 'tw="([^"]*)"', "tw\\.\\w+`([^`]*)`" },
          },
        },
      },
    }

    vim.lsp.config.ts_ls = { capabilities = capabilities }
    vim.lsp.config.html = { capabilities = capabilities }
    vim.lsp.config.cssls = { capabilities = capabilities }
    vim.lsp.config.emmet_language_server = { capabilities = capabilities }
    vim.lsp.config.bashls = { capabilities = capabilities }
    vim.lsp.config.rust_analyzer = { capabilities = capabilities }
    vim.lsp.config.clangd = { capabilities = capabilities }

    vim.lsp.enable({
      "pyright",
      "lua_ls",
      "tailwindcss",
      "ts_ls",
      "html",
      "cssls",
      "emmet_language_server",
      "bashls",
      "rust_analyzer",
      "clangd",
    })
  end,
}
