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
  -- TODO: Probably path is the wrong thinig to take here -- we need to decide
  --       which the most 'central' function will be, and by path likely isn't
  --       it, as we can do *better* if we're in a live buffer, same as
  --       `vim.filetype.match` itself can do better with a live buffer.
  local filetype = vim.filetype.match { filename = path }
  if filetype then
    local finder = ('runt.finders.%s'):format(filetype)
    return require(finder)(path)
  else
    local message = 'Cannot find a suitable test file'
      .. (path ~= '' and (' for %q'):format(path) or '.')

    vim.notify_once(
      message:format(path),
      vim.log.levels.WARN,
      { title = 'runt.nvim' }
    )
  end
end

return M
