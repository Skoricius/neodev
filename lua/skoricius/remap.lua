vim.g.mapleader = " "
vim.keymap.set("n", "<leader>bn", "<cmd>bn<cr>")
vim.keymap.set("n", "<leader>bp", "<cmd>bp<cr>")

vim.keymap.set("n", "<leader>w", "<cmd> set wrap!<cr>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- greatest remap ever
-- replace text with the one in register
vim.keymap.set("x", "<leader>p", [["_dP]])
-- paste from system register
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>rn", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("i", "<C-h>", "#")
vim.keymap.set("i", "£", "#")
vim.keymap.set("c", "£", "#")

-- Navigating splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- saving and quitting files
vim.keymap.set("n", "<C-s>", "<cmd>w!<cr>")
vim.keymap.set("n", "<C-c>", "<C-w>c")
vim.keymap.set("n", "<C-q>", "<C-w>qa")

-- New lines
vim.keymap.set("i", "<C-cr>", "<Esc>o")
vim.keymap.set("i", "<C-S-cr>", "<Esc>O")
vim.keymap.set("n", "<C-cr>", "<Esc>o")
vim.keymap.set("n", "<C-S-cr>", "<Esc>O")
