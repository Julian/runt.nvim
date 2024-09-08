local runt = require 'runt'
local fixtures = require('spec.fixtures').python

describe('python tests', function()
  it('are found for packages containing tests', function()
    local module = fixtures.tests_in_package:child 'runt_package/foo.py'
    assert.is.equal(
      fixtures.tests_in_package:child 'runt_package/tests/test_foo.py',
      runt.test_file_for(module)
    )
  end)

  it('are found for private modules in packages containing tests', function()
    local module = fixtures.tests_in_package:child 'runt_package/_private.py'
    assert.is.equal(
      fixtures.tests_in_package:child 'runt_package/tests/test_private.py',
      runt.test_file_for(module)
    )
  end)

  it('are found for packages side-by-side with tests', function()
    local module = fixtures.tests_side_by_side:child 'another/bar.py'
    assert.is.equal(
      fixtures.tests_side_by_side:child 'tests/test_bar.py',
      runt.test_file_for(module)
    )
  end)

  it(
    'are found for private modules in packages side-by-side with tests',
    function()
      local module = fixtures.tests_side_by_side:child 'another/_private.py'
      assert.is.equal(
        fixtures.tests_side_by_side:child 'tests/test_private.py',
        runt.test_file_for(module)
      )
    end
  )
end)
