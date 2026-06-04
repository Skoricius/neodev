return {
	{
		"3rd/image.nvim",
		lazy = false,
		enabled = vim.g.vscode == nil and vim.fn.has("mac") == 1,
		opts = {
			backend = "kitty", -- iTerm2 uses the kitty protocol via its own implementation
			-- For iTerm2, set TERM_PROGRAM=iTerm.app or use integrations below
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
					only_render_image_at_cursor = false,
					filetypes = { "markdown", "vimwiki" },
				},
				neorg = { enabled = false },
				typst = { enabled = false },
				html = { enabled = false },
				css = { enabled = false },
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = math.huge,
			max_height_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			editor_only_render_when_focused = true,
			tmux_show_only_in_active_window = true,
			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
		},
	},
}
