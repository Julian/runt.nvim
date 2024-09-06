local M = {}

--- Find the test file path for the current buffer.
--- @return string? @the test file path
function M.current_test_file()
  return M.test_file_for(vim.api.nvim_buf_get_name(0))
end

--- Find the test file path for the given source file.
--- @param path string
--- @return string? @the test file path
function M.test_file_for(path)
  local filetype = vim.filetype.match { filename = path }
  local finder = ('runt.finders.%s'):format(filetype)
  return require(finder)(path)
end

return M
