---@param path string
return function(path)
  local found = vim.fs.find(
    { 'spec' },
    { type = 'directory', path = path, upward = true }
  )

  local filename = vim.fs.basename(path):gsub('.lua$', '_spec.lua')
  return vim
    .iter(found)
    :map(function(directory)
      local test_file = vim.fs.joinpath(directory, filename)
      return vim.uv.fs_stat(test_file) and test_file
    end)
    :next()
end
