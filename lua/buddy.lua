local main = require("buddy.main")
local helpers = require("buddy.helpers")

local buddy = {}

local function with_defaults(options)
  options = options or {}
  local open_linter_error_in_browser = options.open_linter_error_in_browser or {}
  local enabled_commands = {
    "prepend_file_with_magic_comment",
    "copy_linter_error",
    "open_linter_error_in_browser",
    "add_debugger",
  }

  return {
    enabled_commands = options.enabled_commands or enabled_commands,
    open_linter_error_in_browser = {
      command = open_linter_error_in_browser.command or "open"
    }
  }
end

local function command_list_completion(arg_lead)
  local commands = buddy.options.enabled_commands

  local matches = {}
  for _, cmd in ipairs(commands) do
    if string.match(cmd, "^" .. arg_lead) then
      table.insert(matches, cmd)
    end
  end

  return matches
end

function buddy.exec_command(command)
  if not buddy.is_configured() then
    print("Buddy: Please call setup() before using commands")
    return
  end

  if not helpers.contains(buddy.options.enabled_commands, command) then
    print("Buddy: Command not found")
    return
  end

  main[command](buddy.options)
end

function buddy.setup(options)
  buddy.options = with_defaults(options)

  for _, cmd in ipairs(buddy.options.enabled_commands) do
    buddy[cmd] = function()
      buddy.exec_command(cmd)
    end
  end

  vim.api.nvim_create_user_command("Buddy", function(opts)
    if opts.args == nil then
      print("Buddy: Please specify a command")
      return
    end

    local command = opts.args
    buddy.exec_command(command)
  end, { nargs = "*", complete = command_list_completion })
end

function buddy.is_configured()
  return buddy.options ~= nil
end

buddy.options = nil
return buddy
