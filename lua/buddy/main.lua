local main = {}
local helpers = require('buddy.helpers')

local available_ruby_filetypes = {"ruby", "rb", "ru"}

function main.add_debugger(options)
  local filetype = helpers.get_filetype()
  local debugger_command = options.add_debugger.command
  if helpers.contains(available_ruby_filetypes, filetype) then
    vim.cmd('normal! o'.. debugger_command)
  end
end

function main.prepend_file_with_magic_comment()
  local line = '# frozen_string_literal: true'
  local currentLine = vim.fn.getline(1)
  if currentLine ~= line then
    vim.api.nvim_command("1s/^/" .. line .. "\r\r")
    vim.api.nvim_command("noh")
  end
end

function main.copy_linter_error()
  local copy_to_clipboard = function (result) vim.fn.setreg('+', result.code) end
  helpers.exec_function_on_linter_error_code(copy_to_clipboard)
end

function main.open_linter_error_in_browser(options)
  local open_browser = function (result)
    local cmd = options.open_linter_error_in_browser.command
    vim.fn.system(cmd .. ' https://rubydoc.info/gems/rubocop/RuboCop/Cop/' .. result.code)
  end

  helpers.exec_function_on_linter_error_code(open_browser)
end

function main.get_commands()
  local commands = main
  local functionNames = {}
  for key, value in pairs(commands) do
    if type(value) == "function" and key ~= "get_commands" then
      table.insert(functionNames, key)
    end
  end
  return functionNames
end

return main
