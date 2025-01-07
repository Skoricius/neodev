vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.wrap = false

vim.opt.colorcolumn = "89"
vim.opt.title = true
local titlestring = ""
titlestring = titlestring .. "%{substitute(getcwd(),$HOME,'~','')}"
titlestring = titlestring .. " - %t"
vim.opt.titlestring = titlestring
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
--     ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
--   },
-- }
-- " Nice window title
-- if has('title') && (has('gui_running') || &title)
--     set titlestring=
--     set titlestring+=%f\                                              " file name
--     set titlestring+=%h%m%r%w                                         " flags
--     set titlestring+=\ -\ %{v:progname}                               " program name
--     set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
-- endif
