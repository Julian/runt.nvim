local runt = require 'runt'
local lua = require('spec.fixtures').lua

describe('custom finder', function()
  it('is called when set', function()
    local bar_spec = lua.neovim_plugin:child 'spec/bar_spec.lua'
    vim.b.runt_finder = function(_)
      return bar_spec
    end
    assert.is.equal(bar_spec, runt.current_test_file())
    vim.b.runt_finder = nil
  end)
end)
