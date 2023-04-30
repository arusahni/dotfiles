vim.cmd [[ com! Format :lua vim.lsp.buf.format({async = false, timeout_ms = 10000}) ]]
