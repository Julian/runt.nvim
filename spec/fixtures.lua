local this_file = debug.getinfo(1).source:match '@(.*)$'
local ROOT = vim.fs.dirname(this_file) .. '/fixtures'

---@class Fixture
---@field private path string the root path this fixture lives at
local Fixture = {}
Fixture.__index = Fixture

---A fixture we ship in our fixtures directory.
---@param subdirectory string
---@return Fixture
function Fixture:new(subdirectory)
  local obj = { path = vim.fs.joinpath(ROOT, subdirectory) }
  return setmetatable(obj, self)
end

---@param name string
---@return string
function Fixture:child(name)
  return vim.fs.normalize(vim.fs.joinpath(self.path, name))
end

local M = {
  lua = {
    neovim_plugin = Fixture:new 'neovim-plugin',
  },
  python = {
    tests_in_package = Fixture:new 'python-in-package',
    tests_side_by_side = Fixture:new 'python-side-by-side',
  },
}

return M
