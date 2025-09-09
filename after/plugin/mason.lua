
-- Ensure Mason loads and registers :Mason command
local ok, mason = pcall(require, 'mason')
if ok then
  mason.setup({ ui = { border = "rounded" } })
else
  vim.schedule(function()
    vim.notify("mason.nvim not found. Run :PackerSync to install it.", vim.log.levels.ERROR)
  end)
end
