local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_utils = require("telescope.actions.utils")
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
      '--glob=*.yml',
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

local function single_or_multi_select(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local has_multi_selection = (
    next(current_picker:get_multi_selection()) ~= nil
  )

  if has_multi_selection then
    local results = {}
    action_utils.map_selections(prompt_bufnr, function(selection)
      table.insert(results, selection[1])
    end)

    -- load the selections into buffers list without switching to them
    for _, filepath in ipairs(results) do
      -- not the same as vim.fn.bufadd!
      vim.cmd.badd({ args = { filepath } })
    end

    require("telescope.pickers").on_close_prompt(prompt_bufnr)

    -- switch to newly loaded buffers if on an empty buffer
    if vim.fn.bufname() == "" and not vim.bo.modified then
      vim.cmd.bwipeout()
      vim.cmd.buffer(results[1])
    end
    return
  end

  -- if does not have multi selection, open single file
  require("telescope.actions").file_edit(prompt_bufnr)
end

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules", "*/mocks/*" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<CR>"] = single_or_multi_select,
      },

      n = {
        ["<leader>qf"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    },
  },
}
