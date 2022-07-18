# term_find.nvim

This plugin will set up a command in your terminal buffer to jump to the file,
line and column under the cursor that uses the following format:

```
test/Vault.spec.ts:133:62
```

Without this plugin, the command `gf` will likely already jump to the right file and line,
but not the column.

See the example below:

![Demo](./demo.gif)

## Installation

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

Add the following to your `init.lua`:

```lua
require('packer').startup(function()
    use 'gabrielpoca/replacer.nvim'
end)

require('term_find').setup({
    autocmd_pattern = 'floaterm',
    keymap_mode = 'n',
    keymap_mapping = 'gf',
    keymap_opts = {},
    callback = function() vim.cmd("FloatermHide") end
})
```

This will setup the map `gf` for floaterm buffers.
When triggered, it will open the file under the cursor, but run `FloatermHide`
before. You can use the settings on the example to override the default
behaviour.
