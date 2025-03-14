pbrowse.nvim
===

`PBrowse` works as `GBrowse` (from [fugitive.vim](https://github.com/tpope/vim-fugitive)) but for Pull requests. This plugin allows you to quickly open GitHub pull request pages at specific lines or selections.

https://github.com/user-attachments/assets/cfb721a6-90eb-448a-bbd9-8727314fc448

## Installation

For [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "gitusp/pbrowse.nvim",
  lazy = true,
  cmd = { "PBrowse" },
}
```

## Requirements

- `git`: Git version control
- `gh`: Git command-line tools
- A repository connected to GitHub
- Active pull request for the current branch

## Usage

In normal mode:
- `:PBrowse` - Browse the current file

In visual mode:
- Select text and use `:PBrowse` - Browse the selected lines

## Health Check

Run `:checkhealth pbrowse` to verify that all dependencies are properly installed.

## Acknowledgements

This plugin was entirely written with assistance from Claude 3.7 Sonnet. As I'm new to Vim plugin development, any corrections, suggestions, or improvements are greatly welcome!

## Compatibility

This plugin has only been tested on macOS. Contributions and help testing on other platforms are welcome!
