local runt = require 'runt'
local fixtures = require('spec.fixtures').typescript

describe('lua', function()
  it('finds test files', function()
    local module = fixtures.side_by_side:child 'src/foo/Bar.ts'
    assert.is.same(
      runt:new(fixtures.side_by_side:child 'src/foo/Bar.test.ts'),
      runt.test_file_for(module)
    )
  end)

  it('suggests paths for nonexistent test files', function()
    local nonexisting = fixtures.side_by_side:child 'src/Nonexisting.ts'
    local sentinel
    -- FIXME: Check the path that we claim should exist.
    runt.test_file_for(nonexisting):if_exists(nil, function()
      sentinel = true
    end)
    assert.is_true(sentinel)
  end)

  it('does not error for nonexistent files', function()
    local nonexisting = fixtures.side_by_side:child 'src/Nonexisting.ts'
    -- FIXME: Check the path that we claim should exist.
    runt.test_file_for(nonexisting):if_exists(function(_)
      assert.False 'Should not be called!'
    end)
  end)
end)
