pbrowse.nvim
===

`PBrowse` works as `GBrowse` but for Pull requests. This plugin allows you to quickly open GitHub pull request pages at specific lines or selections.

## Installation

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'gitusp/pbrowse.nvim'
```

## Requirements

- `gh`: Git command-line tools
- `shasum`: For computing file hashes (built-in on macOS, available via coreutils on most Linux distros)
- A repository connected to GitHub
- Active pull request for the current branch

## Usage

In normal mode:
- `:PBrowse` - Browse the current file

In visual mode:
- Select text and use `:PBrowse` - Browse the selected lines
