local runt = require 'runt'
local fixtures = require('spec.fixtures').python

describe('python', function()
  it('finds files in packages containing thier tests', function()
    local module = fixtures.tests_in_package:child 'runt_package/foo.py'
    assert.is.equal(
      runt.test_file_for(module),
      fixtures.tests_in_package:child 'runt_package/tests/test_foo.py'
    )
  end)
end)
