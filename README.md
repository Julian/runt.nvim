# `runt.nvim`

A small plugin for *finding* corresponding test files for a given source file.

Lots of plugins exist for *running* test files from within Neovim.
I don't generally use them (at least as of today), and am perfectly happy running tests outside of Neovim at a normal shell.

But I still want to be able to *locate* a test file, perhaps to view or edit it while comparinig with the source file I'm editing.

## Installation

Via your favorite plugin manager, e.g. via [lazy.nvim](https://github.com/folke/lazy.nvim/):

```lua
{
  return {
    'Julian/runt.nvim'
  }
}
```
