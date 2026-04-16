vim.opt.nu = true
vim.opt.relativenumber = true

-- Disable unused providers to avoid slow startup (especially python3 probe on .py files)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

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
