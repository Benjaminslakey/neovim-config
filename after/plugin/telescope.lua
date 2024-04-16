local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local multi_rg = require("user.multi-rg")

vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    find_command = {
      'rg',
      '--files',
      '--glob=*.go',
      '--glob=*.sh',
      '--glob=*.sql',
      '--glob=*.Dockerfile',
      '--glob=*.proto',
      '--glob=*.pkl',
      '--glob=*.yaml',
      '--glob=*.templ',
      '--glob=*.html',
      '--glob=*.js',
      '--glob=*.css',
    }
  })
end)
vim.keymap.set('n', '<leader>fa', builtin.find_files, {})
vim.keymap.set('n', '<leader>ft', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fg', multi_rg, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end)
vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({ word_match ='-w' })
end)

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}
