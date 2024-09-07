local original_notify = vim.notify

describe('unsupported', function()
  local notifications

  before_each(function()
    notifications = {}
    ---@diagnostic disable-next-line: duplicate-set-field, unused-vararg
    vim.notify = function(message, _, _)
      table.insert(notifications, message)
    end
  end)

  after_each(function()
    vim.notify = original_notify
  end)

  it('warns for unnamed buffers', function()
    assert.is.equal(vim.api.nvim_buf_get_name(0), '')
    assert.is_nil(require('runt').current_test_file())
    assert.is.same(notifications, { 'Cannot find a suitable test file.' })
  end)

  it('warns for unsupported filetypes', function()
    vim.bo.filetype = 'someNonexistentFiletype'
    vim.api.nvim_buf_set_name(0, 'someFile.sNF')
    assert.is_nil(require('runt').current_test_file())
    assert.is.same(notifications, {
      ('Cannot find a suitable test file for %q'):format(
        vim.api.nvim_buf_get_name(0)
      ),
    })
  end)
end)
