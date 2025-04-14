return {
	{
		"justinmk/vim-sneak",
		config = function()
			-- require("vim-sneak").setup()
			vim.keymap.set("n", "f", "<Plug>Sneak_f", { noremap = true })
			vim.keymap.set("n", "F", "<Plug>Sneak_F", { noremap = true })
			vim.keymap.set("n", "t", "<Plug>Sneak_t", { noremap = true })
			vim.keymap.set("n", "T", "<Plug>Sneak_T", { noremap = true })
		end,
	},
}
