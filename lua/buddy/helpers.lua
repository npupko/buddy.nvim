local helpers = {}

function helpers.get_filetype()
  return vim.bo.filetype
end

function helpers.contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

function helpers.exec_function_on_linter_error_code(func)
  local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local buffer_number = vim.api.nvim_get_current_buf()
  local result = vim.diagnostic.get(buffer_number, { lnum = current_line })
  if result[1].source == 'rubocop' then
    func(result[1])
  end
end


return helpers
