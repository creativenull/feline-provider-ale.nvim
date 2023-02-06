# Feline ALE Provider

Custom provider for displaying ALE status/diagnostics for [feline.nvim](https://github.com/famiu/feline.nvim).

![screenshot](./assets/screenshot.png)

## Requirements

+ [feline.nvim](https://github.com/famiu/feline.nvim)
+ [ALE](https://github.com/dense-analysis/ale)
+ [NerdFonts](https://www.nerdfonts.com/) of your choice
+ [neovim 0.6 and up](https://github.com/neovim/neovim)

## Installation

### Packer.nvim

```lua
use 'dense-analysis/ale'
use {
  'famiu/feline.nvim',
  requires = { 'creativenull/feline-provider-ale.nvim' },
}
```

### Lazy.nvim

```lua
'dense-analysis/ale',
{
  'famiu/feline.nvim',
  dependencies = { 'creativenull/feline-provider-ale.nvim' },
},
```

### vim-plug

```vim
Plug 'dense-analysis/ale'
Plug 'famiu/feline.nvim'
Plug 'creativenull/feline-provider-ale.nvim'
```

## Documentation

Docs can also be found over at [`:help feline-provider-ale`](./doc/feline-provider-ale.txt).

Check out the example file over in [`examples/feline.lua`](./examples/feline.lua)

### Providers

There are four custom providers that come with this plugin for ALE.

#### ALE Status Provider

Shows the current status.

```lua
local ale = require('feline.custom_providers.ale')

require('feline').setup({
    -- ...
    custom_providers = {
        ale_status = ale.status_provider,
    },
})
```

#### ALE Diagnostics

Separate providers for different diagnostics.

```lua
local ale = require('feline.custom_providers.ale')

require('feline').setup({
    -- ...
    custom_providers = {
        ale_error = ale.diagnostic_error_provider,
        ale_warning = ale.diagnostic_warning_provider,
        ale_info = ale.diagnostic_info_provider,
    },
})
```

#### Utilities

There are also some helper functions that you can use provided in the same module.

+ `is_registered()` - returns a boolean when an ALE linter or fixer has been setup
+ `has_registered_linters()` - returns a boolean when an ALE linter has been setup
+ `has_registered_fixers()` - returns a boolean when an ALE fixers has been setup
+ `get_diagnostic_count(attr)` - returns a count of diagnostic given an scope (`attr`), which can be `error`,
  `warning` or `info`

## License

Covered by the [same GPL license](./LICENSE.md) provided in feline.
