vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>f", ":Prettier<CR>")
vim.keymap.set("v", "<leader>f", ":Prettier<CR>")
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Disable highlighted search" })

vim.keymap.set("n", "<leader>ti", ":AutoImport<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Show diagnostics in quickfix" })
vim.keymap.set("n", "<leader>l", vim.diagnostic.setloclist, { desc = "Show diagnostics in location list" })

vim.keymap.set("n", "<leader>`", ":Neogit<CR>", { silent = true })

vim.opt.clipboard:append("unnamedplus")
