local runt = require 'runt'
local fixtures = require('spec.fixtures').lua

describe('lua', function()
  it('finds test files', function()
    local module = fixtures.neovim_plugin:child 'lua/foo/bar.lua'
    assert.is.same(
      runt:new(fixtures.neovim_plugin:child 'spec/bar_spec.lua'),
      runt.test_file_for(module)
    )
  end)

  it('suggests paths for nonexistent test files', function()
    local nonexisting = fixtures.neovim_plugin:child 'lua/foo/nonexisting.lua'
    local sentinel
    -- FIXME: Check the path that we claim should exist.
    runt.test_file_for(nonexisting):if_exists(nil, function()
      sentinel = true
    end)
    assert.is_true(sentinel)
  end)

  it('does not error for nonexistent files', function()
    local nonexisting = fixtures.neovim_plugin:child 'lua/foo/nonexisting.lua'
    -- FIXME: Check the path that we claim should exist.
    runt.test_file_for(nonexisting):if_exists(function(_)
      assert.False 'Should not be called!'
    end)
  end)
end)
