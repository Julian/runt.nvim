---@class TestFile
---@field path string the path of the test file
local TestFile = {}
TestFile.__index = TestFile

---@class NO_FILE_FOUND
local NO_FILE_FOUND = {
  if_exists = function(_, _, else_fn)
    else_fn(nil)
  end,
}

---A test file path.
---@param path string the path of the test file
function TestFile:new(path)
  if not path then
    return NO_FILE_FOUND
  end
  local obj = { path = path }
  return setmetatable(obj, self)
end

--- Find the test file path for the current buffer.
--- @return TestFile|NO_FILE_FOUND @the test file path
function TestFile.current_test_file()
  local finder = vim.b.runt_finder
  local path = vim.api.nvim_buf_get_name(0)
  return finder and TestFile:new(finder(path)) or TestFile.test_file_for(path)
end

function TestFile:if_exists(if_fn, else_fn)
  local fn = vim.uv.fs_stat(self.path) and if_fn or else_fn
  fn(self.path)
end

--- Find the test file path for the given source file.
--- @param path string
--- @return TestFile|NO_FILE_FOUND @the corresponding test file
function TestFile.test_file_for(path)
  -- TODO: Probably path is the wrong thinig to take here -- we need to decide
  --       which the most 'central' function will be, and by path likely isn't
  --       it, as we can do *better* if we're in a live buffer, same as
  --       `vim.filetype.match` itself can do better with a live buffer.
  local filetype = vim.filetype.match { filename = path }
  if filetype then
    local finder = ('runt.finders.%s'):format(filetype)
    local test_path = require(finder)(path)
    return TestFile:new(test_path)
  else
    local message = 'Cannot find a suitable test file'
      .. (path ~= '' and (' for %q'):format(path) or '.')

    vim.notify_once(
      message:format(path),
      vim.log.levels.WARN,
      { title = 'runt.nvim' }
    )
  end
  return NO_FILE_FOUND
end

return TestFile
