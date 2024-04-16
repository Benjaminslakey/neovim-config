vim.g.mapleader = " "
local opts = { silent = true }

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>rn", ":set invrelativenumber<CR>", opts)
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
vim.keymap.set("v", "p", '"_dP', opts)

-- Move text up and down
vim.keymap.set("n", "∆", "<Esc>:m .+1<CR>==", opts)
vim.keymap.set("n", "˚", "<Esc>:m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to enter
-- vim.keymap.set("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", opts)
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- Research and replace current word --
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)
-- Plugins --

-- NvimTree
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>", opts)

-- CoPilot
vim.keymap.set('i', '<C-a>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
 
-- remap next suggestion to control + ]
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-next)', { noremap = true })

 

--                                                 *copilot-i_CTRL-]*
-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--                                                 *copilot-i_ALT-\*
-- <M-\>                   Explicitly request a suggestion, even if Copilot
-- <Plug>(copilot-suggest) is disabled.
--
--                                                 *copilot-i_ALT-Right*
-- <M-Right>               Accept the next word of the current suggestion.
-- <Plug>(copilot-accept-word)
--
--                                                 *copilot-i_ALT-CTRL-Right*
--
-- <M-C-Right>             Accept the next line of the current suggestion.
-- <Plug>(copilot-accept-line)


-- Telescope
-- vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
-- vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
-- vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", opts)
-- vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- vim.keymap.set("n", "<leader>fg", ":Telescope git_status<CR>", opts)
-- vim.keymap.set('n', '<leader>fw', ":Telescope grep_string<CR>", { word_match ='-w' })
-- vim.keymap.set('n', '<leader>fw', function()
--   require('telescope.builtin').grep_string({ word_match ='-w' })
-- end)
-- vim.keymap.set('n', '<leader>fw', function()
-- 	require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
-- end)

-- Git
-- vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
-- vim.keymap.set("n", "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', opts)
-- vim.keymap.set("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
-- vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
