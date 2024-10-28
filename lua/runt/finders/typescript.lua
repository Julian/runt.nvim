---@param path string
return function(path)
  local test_file = path:gsub('.ts$', '.test.ts')
  return vim.uv.fs_stat(test_file) and test_file
end
