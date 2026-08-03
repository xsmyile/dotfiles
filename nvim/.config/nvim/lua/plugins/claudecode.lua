return {
  "coder/claudecode.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = { "n", "v" }, desc = "Send selection to Claude" },
    {
      "<leader>ab",
      function()
        vim.cmd("ClaudeCodeAdd " .. vim.fn.fnameescape(vim.fn.expand("%:.")))
      end,
      desc = "Add current buffer to Claude context",
    },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Reject Claude diff" },
    { "<leader>aq", "<cmd>ClaudeCodeCloseAllDiffs<CR>", desc = "Close pending Claude diffs" },
  },
  opts = {
    terminal = {
      provider = "none",
    },
  },
}
