---@param path string
return function(path)
  local filename = 'test_' .. vim.fs.basename(path)
  local test_dirs = vim.fs.find(function(_, directory)
    local test = vim.fs.joinpath(directory, 'tests', filename)
    return vim.uv.fs_stat(test) ~= nil
  end, { type = 'directory', path = path, upward = true })
  return vim.fs.joinpath(test_dirs[1], filename)
end
