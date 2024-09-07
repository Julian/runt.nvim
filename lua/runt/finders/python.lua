---@param path string
return function(path)
  local found = vim.fs.find(
    { 'tests' },
    { type = 'directory', path = path, upward = true }
  )

  local filename = 'test_' .. vim.fs.basename(path)
  return vim
    .iter(found)
    :map(function(tests)
      local test_file = vim.fs.joinpath(tests, filename)
      return vim.uv.fs_stat(test_file) and test_file
    end)
    :next()
end
