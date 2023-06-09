# Buddy.nvim

## What is buddy.nvim?
Buddy.nvim is a plugin for Neovim that provides various handy functions for Ruby developers. The plugin can be called via command-line mode using :Buddy or by requiring the module in Lua code.

## Features
- Add a debugger line `(binding.pry)` to your Ruby code
- Prepend a file with a magic comment (`# frozen_string_literal: true`)
- Copy linter error code to clipboard
- Open linter error documentation in browser

## Installation
Install the plugin using your preferred package manager, e.g., lazy.nvim:

```lua
return {
  "npupko/buddy.nvim",
  config = function ()
    local buddy = require('buddy')
    buddy.setup({})

    vim.keymap.set('n', '<leader>/', buddy.add_debugger, { silent = true, desc = 'Add debugger to next line' })
    vim.keymap.set('n', '<leader>cle', buddy.copy_linter_error, { silent = true, desc = 'Copy linter error' })
    vim.keymap.set('n', '<leader>clb', buddy.open_linter_error_in_browser, { silent = true, desc = 'Open linter error in browser' })

    vim.api.nvim_create_user_command('Frt', buddy.prepend_file_with_magic_comment, { desc = 'Add magic comment line to file' })
  end,
}
```

## Functions
#### `add_debugger()`
Adds a binding.pry line to the current file if the file type is supported (Ruby, rb, ru).

#### `prepend_file_with_magic_comment()`
Prepends the current file with the magic comment # frozen_string_literal: true if it's not already there.

#### `copy_linter_error()`
Copies the linter error code to the clipboard.

#### `open_linter_error_in_browser(options)`
Opens the linter error documentation in a browser. Provide an options table with an open_linter_error_in_browser.command key to specify the command to open the browser.

#### `exec_function_on_linter_error_code(func)`
Executes a function on the linter error code. Pass a callback function that accepts the error result as its argument.

#### `get_commands()`
Returns a table of available function names in the plugin.

## Configuration
#### `setup(options)`
Pass a table of options to the setup function to configure the plugin. The following options are available:

```lua
local buddy = require('buddy')
buddy.setup({
    -- Configure which commands are enabled
    enabled_commands = {
        "prepend_file_with_magic_comment",
        "copy_linter_error",
        "open_linter_error_in_browser",
        "add_debugger",
    },
    -- Configure the command to open the browser
    open_linter_error_in_browser = {
        command = "open"
    },
    add_debugger = {
        command = "binding.pry"
    }
})
```

## Contributing

All contributions are welcome! Just open a pull request.
