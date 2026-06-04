# Neovim Shortcuts

> Leader key: `<Space>`  
> Local leader: `\`

---

## Basic Remaps

### Buffers & Tabs

| Key | Mode | Action |
|---|---|---|
| `<leader>bn` | n | Next buffer |
| `<leader>bp` | n | Previous buffer |
| `<leader>bd` | n | Delete buffer |
| `<leader>tc` | n | Close tab |

### Window Management

| Key | Mode | Action |
|---|---|---|
| `<C-h>` | n | Move to left split |
| `<C-j>` | n | Move to split below |
| `<C-k>` | n | Move to split above |
| `<C-l>` | n | Move to right split |
| `<C-w>h` | n | Horizontal split |
| `<C-c>` | n | Close window |
| `<C-s>` | n | Save file (force) |
| `<C-q>` | n | Quit all |

### Navigation

| Key | Mode | Action |
|---|---|---|
| `<C-u>` | n | Scroll up half page (centred) |
| `<C-d>` | n | Scroll down half page (centred) |
| `<C-k>` | n | Next quickfix item (centred) |
| `<C-j>` | n | Prev quickfix item (centred) |
| `<leader>k` | n | Next location list item (centred) |
| `<leader>j` | n | Prev location list item (centred) |

### Editing

| Key | Mode | Action |
|---|---|---|
| `J` | v | Move selected lines down |
| `K` | v | Move selected lines up |
| `J` | n | Join line below (cursor stays in place) |
| `>` | v | Indent and reselect |
| `<` | v | Dedent and reselect |
| `<C-cr>` | n/i | New line below (stay in current mode) |
| `<C-S-cr>` | n/i | New line above (stay in current mode) |
| `<leader>w` | n | Toggle line wrap |
| `<leader>rn` | n | Rename word under cursor (project-wide substitute) |
| `<leader>x` | n | `chmod +x` current file |
| `Q` | n | Disabled (no-op) |

### Clipboard & Registers

| Key | Mode | Action |
|---|---|---|
| `<leader>y` | n/v | Yank to system clipboard |
| `<leader>Y` | n | Yank line to system clipboard |
| `<leader>p` | n/v | Paste from system clipboard |
| `<leader>p` | x | Paste over selection without losing register |
| `<leader>d` | n/v | Delete to black hole register (no yank) |

### Special Characters

| Key | Mode | Action |
|---|---|---|
| `<C-h>` | i | Insert `#` |
| `£` | i/c | Insert `#` |

---

## LSP

| Key | Mode | Action |
|---|---|---|
| `gd` | n | Go to definition |
| `K` | n | Hover documentation |
| `<leader>vws` | n | Workspace symbol search |
| `<leader>vd` | n | Open diagnostic float |
| `[d` | n | Next diagnostic |
| `]d` | n | Prev diagnostic |
| `<leader>vca` | n | Code action |
| `<leader>vrr` | n | References |
| `<leader>vrn` | n | Rename symbol |
| `<leader>f` | n | Format buffer |
| `<leader>vh` | n | Signature help |
| `<C-h>` | i | Signature help |

---

## Telescope

| Key | Mode | Action |
|---|---|---|
| `<C-p>` | n | Frecency file picker (workspace) |
| `<leader>ff` | n | Find git files |
| `<leader>fa` | n | Find all files (ignore `.gitignore`) |
| `<leader>fs` | n | Live grep (ripgrep) |
| `<C-f>` | n | Fuzzy search current buffer |
| `<leader>ls` | n | LSP document symbols |
| `<leader>vh` | n | Help tags |

---

## Harpoon

| Key | Mode | Action |
|---|---|---|
| `<leader>a` | n | Add file to harpoon |
| `<leader>q` | n | Toggle harpoon menu |
| `<leader>.` | n | Next harpoon file |
| `<leader>,` | n | Prev harpoon file |

---

## Neo-tree

| Key | Mode | Action |
|---|---|---|
| `<leader>e` | n | Toggle file explorer |

### Inside Neo-tree

| Key | Action |
|---|---|
| `<cr>` / `<2-LeftMouse>` | Open file |
| `<space>` | Toggle node |
| `P` | Toggle preview (float) |
| `l` | Focus preview |
| `h` | Open in horizontal split |
| `v` | Open in vertical split |
| `t` | Open in new tab |
| `a` | Add file |
| `A` | Add directory |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy to clipboard |
| `x` | Cut to clipboard |
| `p` | Paste from clipboard |
| `c` | Copy (with destination prompt) |
| `m` | Move (with destination prompt) |
| `Y` | Copy path to clipboard (picker) |
| `e` | Open with system app |
| `C` | Close node |
| `z` | Close all nodes |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `/` | Fuzzy finder |
| `q` | Close Neo-tree |
| `?` | Show help |
| `[g` / `]g` | Prev / next git-modified file |

---

## Toggleterm

| Key | Mode | Action |
|---|---|---|
| `<C-t>` | n/t | Toggle terminal |
| `<F7>` | n/t | Toggle terminal |
| `<leader>tf` | n | Open floating terminal |
| `<leader>th` | n | Open horizontal terminal (10 lines) |
| `<leader>tv` | n | Open vertical terminal (80 cols) |
| `<C-]>` | t | Exit terminal mode (to normal) |
| `<C-h/j/k/l>` | t | Navigate to split from terminal |
| `<C-w>` | t | Window command from terminal |

---

## LazyGit

| Key | Mode | Action |
|---|---|---|
| `<leader>gg` | n | Open LazyGit |

---

## Comment.nvim

| Key | Mode | Action |
|---|---|---|
| `<leader>/` | n | Toggle comment (line) |
| `<leader>/` | v | Toggle comment (selection) |
| `<C-/>` | i | Toggle comment (line) |

---

## Neotest

| Key | Mode | Action |
|---|---|---|
| `<leader>yr` | n | Run nearest test |
| `<leader>yf` | n | Run all tests in file |
| `<leader>yt` | n | Stop test run |
| `<leader>yd` | n | Debug nearest test (DAP) |
| `<leader>ys` | n | Toggle test summary |
| `<leader>yo` | n | Open test output |
| `<leader>yp` | n | Toggle output panel |
| `<leader>ya` | n | Attach to test run |

---

## Diffview

| Key | Mode | Action |
|---|---|---|
| `<leader>do` | n | Open diff view |
| `<leader>dc` | n | Close diff view |

---

## Neogen (Docstrings)

| Key | Mode | Action |
|---|---|---|
| `<leader>gc` | n | Generate docstring (numpydoc) |

---

## Zen Mode

| Key | Mode | Action |
|---|---|---|
| `<leader>z` | n | Toggle Zen Mode |

---

## vim-sneak

Replaces the built-in `f`/`t` with two-character seek.

| Key | Mode | Action |
|---|---|---|
| `f{char}` | n | Sneak forward to `{char}` |
| `F{char}` | n | Sneak backward to `{char}` |
| `t{char}` | n | Sneak forward, stop before `{char}` |
| `T{char}` | n | Sneak backward, stop before `{char}` |

---

## Molten (Jupyter)

| Key | Mode | Action |
|---|---|---|
| `<leader>mi` | n | Init kernel — auto-detects local venv |
| `<leader>mK` | n | Init kernel — manual picker |
| `<leader>mk` | n | Deinit kernel |
| `<leader>ml` | n | Run current line |
| `<leader>mr` | n | Run with motion (e.g. `<leader>mrip` = run paragraph) |
| `<leader>mr` | v | Run visual selection |
| `<leader>mc` | n | Re-run current cell |
| `<leader>ma` | n | Re-run all cells |
| `<leader>mR` | n | Run current cell (`ip`) |
| `<leader>mn` | n | Run current cell and move to next |
| `]c` | n | Jump to next cell |
| `[c` | n | Jump to prev cell |
| `<leader>mo` | n | Show output |
| `<leader>mh` | n | Hide output |
| `<leader>mw` | n | Enter output window |
| `<leader>md` | n | Delete cell output |
| `<leader>me` | n | Export current `.py` to `.ipynb` |
| `<leader>mI` | n | Import `.ipynb` → open as `.py` (jupytext) |

---

## Quarto / Otter (LSP in cells)

| Key | Mode | Action |
|---|---|---|
| `<leader>qa` | n | Activate Otter LSP for current buffer |
| `<leader>qr` | n | Run cell (via quarto → molten) |
| `<leader>qr` | v | Run range (via quarto → molten) |
| `<leader>qa` | n | Run all cells above |
| `<leader>qb` | n | Run all cells below |
| `<leader>qA` | n | Run all cells |
| `<leader>qp` | n | Quarto preview |
| `<leader>qq` | n | Close quarto preview |
