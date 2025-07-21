# Neovim no-fuss configuration


Clone to `~/.config/nvim` and start [nvim](https://github.com/neovim/neovim/blob/master/INSTALL.md) (`>=0.10.0`) and lazy should take care of everything.

This repository sets up a pretty solid dev environment in neovim with no configuration required. It is mainly focused on Python development, but with a few small changes, it could be adapted to other languages.

## Mappings

- `<leader>` is space
- `bn` and `bp` to switch between buffers
- `<leader>w` to wrap/unwrap text
- in visual mode J and K move the current line up or down
- in normal mode, J merges the current and the next line
- in visual mode > and < move indentation
- in select mode `<leader>p`d replaces the text under cursor with the text in the register
- `<leader>y/p` copy/paste from system register, `<leader>d` deletes to black hole
- navigate splits with `<C-h/j/k/l>`
- quit with `<C-q>` - you have escaped vim!
- save with `<C-s>`
- new lines with `<C-cr>` and `<C-S-cr>` (ctrl, shift, enter)


## Features

1. Tokyo night colour scheme and lualine. Change by editing `lua/plugins/colors.lua`
2. Comment plugin comments/uncomments lines with `<leader>/` in both visual and normal mode
3. [guard](https://github.com/nvimdev/guard.nvim) offers formatting on save. I have it set up for a few languages, but more can easily be added
4. harpoon for lightning fast movement between files. Do `<leader>a` to add a file, `<leader>q` to toggle menu, `<leader>./,` to go forward/backward
5. [lazygit](https://github.com/jesseduffield/lazygit) with `<leader>gg`
6. lsp with some sensible mappings - see `lsp.lua` for details
7. Automatic documentation templates through neogen with `<leader>gc`
8. Testing through neotest - see `neotest.lua` for details
9. Neotree - file explorer. Toggle with `<leader>e`
10. Sneak - move with `s` + two letters to the next appearance of that letter combination. Move backwards with `S`. Do `;` and `,` to repeat/undo movement.
11. Telescope - search files with `<C-p>`, do live grep with `<leader>fs`, lsp symbol search with `<leader>ls`, normal search through file with `<C-f>`
12. Toggle terminal with `<C-t>`. Toggle in floating, horisontal or vertical mode with `<leader>tf/h/v`.
13. Zenmode with `<leader>z`
