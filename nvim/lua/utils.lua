local U = {}

function U.is_mac()
  return vim.loop.os_uname().sysname == "Darwin"
end

function U.is_linux()
  return vim.loop.os_uname().sysname == "Linux"
end

return U
