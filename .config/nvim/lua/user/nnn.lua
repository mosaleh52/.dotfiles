
local status_ok, nnn = pcall(require, "nnn")
if not status_ok then
  return
end
nnn.setup(
    {    auto_close = false,
    })

