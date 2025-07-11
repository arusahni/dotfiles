local U = require("utils")

local autocmd = vim.api.nvim_create_autocmd -- execute autocommands
local augroup = vim.api.nvim_create_augroup -- group autocommands
local set = vim.opt                         -- global options

local function filetype_autocmd(filetype, cmd, params)
    autocmd("FileType", { pattern = filetype, command = cmd .. ' ' .. params })
end

local function buffer_autocmd(pattern, cmd, params)
    autocmd("BufRead", { pattern = pattern, command = cmd .. ' ' .. params })
end

vim.g.mapleader = ","
set.termguicolors = true
set.bg = "dark"
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.mouse = "a"
set.clipboard = set.clipboard + "unnamedplus"
set.cursorline = true
set.showcmd = true
set.number = true
set.relativenumber = true
set.hidden = true
set.hlsearch = true
set.backspace = "2"
set.laststatus = 2
set.shortmess = set.shortmess + "c"
set.signcolumn = "number"
-- set.statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} '
set.inccommand = "split"
set.listchars = {
    nbsp = '⦸',
    extends = '»',
    precedes = '«',
    tab = '▷─',
    trail = '•',
    space = ' '
}

set.titleold = [[ ${substitute(system("uname"),'\(.*\)\n','%\1%','')} ]]

local group = augroup("on_bufenter", { clear = true })
autocmd("BufEnter", {
    callback = function()
        set.titlestring = [[ %{expand("%:p:~:.:h")} ]]
    end,
    desc = "Set the window title",
    group = group,
    pattern = "*",
})
-- local file = vim.fn.expand("%:p:t")
-- local cwd = vim.fn.split(vim.fn.expand("%:p:h"):gsub("/", "\\"), "\\")
--
-- if file ~= "" and not utils.buff

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        }
    },
    float = {
        border = "rounded",
    },
})

set.title = true
set.updatetime = 1000

filetype_autocmd("html", "setlocal", "ts=2 sts=2 sw=2 omnifunc=htmlcomplete#CompleteTags")
filetype_autocmd("xml", "set", "omnifunc=xmlcomplete#CompleteTags")
filetype_autocmd("javascript", "setlocal", "ts=2 sts=2 sw=2")
filetype_autocmd("typescript", "setlocal", "ts=2 sts=2 sw=2")
filetype_autocmd("python", "setlocal", "ts=4 sts=4 sw=4 formatprg=black\\ -q\\ -")
filetype_autocmd("yaml", "setlocal", "ts=2 sts=2 sw=2")
filetype_autocmd("css", "setlocal", "ts=2 noet sw=2")
filetype_autocmd("scss", "setlocal", "ts=2 noet sw=2 omnifunc=csscomplete#CompleteCSS")
filetype_autocmd("vue", "syntax", "sync fromstart")
filetype_autocmd("elixir", "setlocal", "formatprg=mix\\ format\\ -")
buffer_autocmd("*.coffee", "set", "ft=coffee")
buffer_autocmd("*.less", "set", "ft=less")
buffer_autocmd("*.md", "set", "ft=markdown")
buffer_autocmd("Cakefile", "set", "ft=coffee")
buffer_autocmd("*.pp", "set", "ft=ruby")
buffer_autocmd("*.conf", "set", "ft=dosini")
buffer_autocmd("*.tsx", "set", "ft=typescriptreact")
buffer_autocmd("*.cls", "set", "ft=apex syntax=java")
buffer_autocmd("*.trigger", "set", "ft=apex syntax=java")
buffer_autocmd("*.nomad.template", "set", "ft=hcl")
buffer_autocmd("*.webc", "set", "ft=html")

if U.is_linux() then
    vim.g.python3_host_prog = "/bin/python"
elseif U.is_mac() then
    vim.g.python3_host_prog = "/usr/local/bin/python3"
end
--
-- Hack: disable async tree-sitter parsing. This should be fixed with v0.11.1
-- See: https://github.com/neovim/neovim/pull/33145
vim.g._ts_force_sync_parsing = true
