local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end


dap.adapters.python = {
  type = 'executable';
  command = '/usr/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/usr/bin/python') == 1 then
        return cwd .. '/usr/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/usr/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}


dap.defaults.fallback.terminal_win_cmd = '80vsplit new'
vim.fn.sign_define(
  "DapBreakpoint",
  { text = "🛑", texthl = "", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "🟢", texthl = "", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapBreakpointCondition",
  { text = "🟡", texthl = "", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapLogPoint",
  { text = "🔵", texthl = "", linehl = "", numhl = "" }
)

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


map('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>')
map('n', '<leader>dH', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<leader>dso', ':lua require"dap".step_out()<CR>')
map('n', '<leader>dsi', ':lua require"dap".step_into()<CR>')
map('n', '<leader>dsv', ':lua require"dap".step_over()<CR>')
map('n', '<leader>dc', ':lua require"dap".continue()<CR>')
map('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>')
map('n', '<leader>du', ':lua require"dap".up()<CR>')
map('n', '<leader>dd', ':lua require"dap".down()<CR>')
map('n', '<leader>dt', ':lua require"dap".terminate()<CR>')
map('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<leader>dR', ':lua require"dap".clear_breakpoints()<CR>')
map('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
map('n', '<leader>da', ':lua require"debugHelper".attach()<CR>')
map('n', '<leader>dA', ':lua require"debugHelper".attachToRemote()<CR>')
map('n', '<leader>di', ':lua require"dap.ui.widgets".hover()<CR>')
map('n', '<leader>d?', ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')


