local runt = require 'runt'
local fixtures = require('spec.fixtures').lua

describe('lua', function()
  it('finds test files', function()
    local module = fixtures.neovim_plugin:child 'lua/foo/bar.lua'
    vim.print(module)
    assert.is.equal(
      fixtures.neovim_plugin:child 'spec/bar_spec.lua',
      runt.test_file_for(module)
    )
  end)
end)
