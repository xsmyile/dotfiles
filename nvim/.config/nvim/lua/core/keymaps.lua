-- Move up/down the selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor position mid screen when going page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Prevent the cursor to move at eol when appending next line to current line
vim.keymap.set("n", "J", "mzJ`z")

-- Keep a buffer of the yanked selection
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Keep a buffer of the yanked selection" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Restore splits to initial size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>sm", function()
  if vim.t.maximized and vim.fn.tabpagenr("$") > 1 then
    local bufnr, cursor = vim.api.nvim_get_current_buf(), vim.api.nvim_win_get_cursor(0)
    vim.cmd("tabclose")
    if vim.api.nvim_get_current_buf() == bufnr then
      vim.api.nvim_win_set_cursor(0, cursor)
    end
  else
    vim.cmd("tab split")
    vim.t.maximized = true
  end
end, { desc = "Maximize current split" })

-- Buffer management
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete current buffer" })
