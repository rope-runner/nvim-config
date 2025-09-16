local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

vim.keymap.set('n', '<leader>]', builtin.live_grep, {})

local function get_visual_selection()
  local save_reg = vim.fn.getreg("v")
  local save_type = vim.fn.getregtype("v")

  vim.cmd('normal! "vy')

  local selection = vim.fn.getreg("v")

  vim.fn.setreg("v", save_reg, save_type)

  return selection
end

vim.keymap.set({ "n", "v" }, "<leader>p8", function()
  if vim.fn.mode() == "n" then
    builtin.grep_string({ search = vim.fn.expand("<cword>") })
  else
    local text = get_visual_selection()
    if text ~= "" then
      builtin.grep_string({ search = text })
    end
  end
end, { desc = "Grep word under cursor or visual selection" })
