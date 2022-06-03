local status_ok, iron = pcall(require, "iron")
if not status_ok then
  return
end

-- iron.core.add_repl_definitions {
--   python = {
--     mycustom = {
--       command = {"mycmd"}
--     }
--   },
--   clojure = {
--     lein_connect = {
--       command = {"lein", "repl", ":connect"}
--     }
--   }
-- }
--
-- iron.core.set_config {
--   preferred = {
--     python = "ipython",
--     clojure = "lein"
--   }
-- }
iron.core.set_config {
  preferred = {
    python = "ipython"
  },
  repl_open_cmd = "botright vertical split",
}

_G.my_iron_open_fn = function(orientation)
  local old_config = iron.config.repl_open_cmd
  iron.core.set_config{repl_open_cmd = orientation}
  iron.core.repl_for(vim.api.nvim_buf_get_option(0, "ft"))
  iron.core.set_config{repl_open_cmd = old_config}
end
-- Example usage:
vim.cmd([[
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'
]])
