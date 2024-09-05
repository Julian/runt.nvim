local MODREV, SPECREV = 'scm', '-1'
rockspec_format = '3.0'

package = 'runt.nvim'
version = MODREV .. SPECREV

description = {
  summary = 'Neovim support for the Lean theorem prover',
  detailed = 'Interactive theorem proving inside Neovim.',
  labels = { 'neovim', 'plugin', 'lean', 'leanprover' },
  homepage = 'https://github.com/Julian/lean.nvim',
  license = 'MIT',
}

dependencies = {
}

test_dependencies = {
  'nlua',
}

source = {
  url = 'https://github.com/Julian/runt.nvim',
}

build = {
  type = 'builtin',
}
