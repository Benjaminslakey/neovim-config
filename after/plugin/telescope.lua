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
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fw', function()
  builtin.grep_string({ word_match = '-w' })
end)
vim.keymap.set('n', '<leader>fe', builtin.oldfiles, {})

local function log_message(msg)
  vim.api.nvim_out_write(msg .. "\n")
end

-- To view messages, use the :messages command in Neovim

local function single_or_multi_select(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local has_multi_selection = (
    next(current_picker:get_multi_selection()) ~= nil
  )

  if has_multi_selection then
    local results = {}
    action_utils.map_selections(prompt_bufnr, function(selection)
      local parts = vim.split(selection[1], ":", { maxsplit = 2 })
      local filepath = parts[1]
      local line_number = tonumber(parts[2]) or 1 -- Assuming line number is the third part now
      -- vim.api.nvim_echo(
      --   { { string.format("filepath selected to open in new buffer: %s\nlinenumber stored: %d", filepath, line_number), "WarningMsg" } },
      --   true, {}
      -- )
      table.insert(results, {
        filepath = filepath,
        line = line_number
      })
    end)

    -- Load the selections into buffers list without switching to them
    for _, result in ipairs(results) do
      local filepath = vim.fn.fnameescape(vim.fn.fnamemodify(result.filepath, ":p"))
      vim.cmd.badd({ args = { filepath } })
    end

    require("telescope.pickers").on_close_prompt(prompt_bufnr)

    -- Switch to newly loaded buffer if on an empty buffer
    if vim.fn.bufname() == "" and not vim.bo.modified then
      vim.cmd.bwipeout()
      local first_result = results[1]
      vim.cmd.buffer(first_result.filepath)
      vim.api.nvim_win_set_cursor(0, { first_result.line, 0 })
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
