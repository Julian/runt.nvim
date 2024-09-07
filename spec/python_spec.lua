local runt = require 'runt'
local fixtures = require('spec.fixtures').python

describe('python', function()
  it('finds files in packages containing thier tests', function()
    local module = fixtures.tests_in_package:child 'runt_package/foo.py'
    assert.is.equal(
      fixtures.tests_in_package:child 'runt_package/tests/test_foo.py',
      runt.test_file_for(module)
    )
  end)

  it('finds files in packages side-by-side with thier tests', function()
    local module = fixtures.tests_side_by_side:child 'another/bar.py'
    assert.is.equal(
      fixtures.tests_side_by_side:child 'tests/test_bar.py',
      runt.test_file_for(module)
    )
  end)
end)
