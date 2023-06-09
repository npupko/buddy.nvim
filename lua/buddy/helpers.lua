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

return helpers
