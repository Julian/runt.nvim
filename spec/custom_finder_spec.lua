local runt = require 'runt'

describe('custom finder', function()
  it('is called when set', function()
    local test = '/tmp/custom/runt/finder'
    vim.b.runt_finder = function(_)
      return test
    end
    assert.is.same(runt:new(test), runt.current_test_file())
    vim.b.runt_finder = nil
  end)
end)
