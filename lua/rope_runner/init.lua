require("rope_runner.remap")
require("rope_runner.packer")
require("rope_runner.set")
require("rope_runner.autoimport")

--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

--require("nvim-tree").setup({
--  sort = {
--    sorter = "case_sensitive",
--  },
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = false,
--  },
--})
--

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})
