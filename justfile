src := justfile_directory() + "/lua"
spec := justfile_directory() + "/spec"

# Run the runt.nvim test suite.
test *test_files=spec:
    luarocks test --local -- {{ test_files }}

# Coarsely profile how long the whole test suite takes to run.
profile-test *ARGS:
    hyperfine --warmup 2 {{ ARGS }} "just test"

# Lint runt.nvim for style and typing issues.
lint:
    pre-commit run --all-files
    @echo
    {{ if `lua-language-server --version 2>&1 >/dev/null; echo $?` != "0" { error('lua-language-server not found') } else { "" } }}
    lua-language-server --check lua/runt --checklevel=Warning --configpath "{{ justfile_directory() }}/.luarc.json"
    {{ if `selene --version 2>&1 >/dev/null; echo $?` != "0" { error('selene not found') } else { "" } }}
    selene {{ src }}
