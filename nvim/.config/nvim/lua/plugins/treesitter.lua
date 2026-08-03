local parsers = {
  "c",
  "cpp",
  "python",
  "javascript",
  "typescript",
  "html",
  "css",
  "htmldjango",
  "tsx",
  "lua",
  "json",
  "yaml",
  "vue",
  "sql",
  "bash",
  "http",
  "dockerfile",
  "markdown",
  "markdown_inline",
  "vimdoc",
}

local function parser_filetypes()
  local fts = {}
  local seen = {}
  for _, parser in ipairs(parsers) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(parser)) do
      if not seen[ft] then
        seen[ft] = true
        fts[#fts + 1] = ft
      end
    end
  end
  return fts
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = parser_filetypes(),
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "htmldjango", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "xml", "markdown" },
    opts = {},
  },
}
