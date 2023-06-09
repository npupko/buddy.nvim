if vim.fn.has("nvim-0.8.0") == 0 then
  vim.api.nvim_err_writeln("buddy.nvim requires at least nvim-0.8.0")
  return
end

if vim.g.loaded_buddy == 1 then
  return
end

vim.g.loaded_buddy = 1
