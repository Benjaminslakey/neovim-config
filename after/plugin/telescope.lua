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

local action_state = require("telescope.actions.state")
local action_utils = require("telescope.actions.utils")
local function multi_select(prompt_bufnr)
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

-- local function get_buffer_list()
--   -- Execute the :buffers command and capture its output
--   local buffers_output = vim.api.nvim_exec('buffers', true)
--
--   -- Split the output into lines
--   local lines = vim.split(buffers_output, '\n')
--
--   -- Process the lines to extract buffer information
--   local buffer_list = {}
--   for _, line in ipairs(lines) do
--     -- Parse each line of the buffer list
--     local bufnr, active, filename = line:match('^%s*(%d+)%s+(.-)%s+"(.+)"')
--     if bufnr then
--       table.insert(buffer_list, {
--         number = tonumber(bufnr),
--         active = active,
--         filename = filename
--       })
--     end
--   end
--
--   return buffer_list
-- end
--
-- local function add_buffers_and_get_range(results)
--   local min_bufnr = math.huge
--   local max_bufnr = 0
--
--   for _, filepath in ipairs(results) do
--     vim.cmd.badd({ args = { filepath } })
--     local bufnr = vim.fn.bufnr(filepath)
--
--     min_bufnr = math.min(min_bufnr, bufnr)
--     max_bufnr = math.max(max_bufnr, bufnr)
--   end
--
--   return min_bufnr, max_bufnr
-- end
--
-- local function multi_find_and_replace(prompt_bufnr)
--   local current_picker = action_state.get_current_picker(prompt_bufnr)
--   local has_multi_selection = (
--     next(current_picker:get_multi_selection()) ~= nil
--   )
--
--   if has_multi_selection then
--     local results = {}
--     action_utils.map_selections(prompt_bufnr, function(selection)
--       table.insert(results, selection[1])
--     end)
--
--     local min_bufnr, max_bufnr = add_buffers_and_get_range(results)
--
--     -- require("telescope.pickers").on_close_prompt(prompt_bufnr)
--
--     -- switch to newly loaded buffers if on an empty buffer
--     local buffers = get_buffer_list()
--     for _, buf in ipairs(buffers) do
--       print(string.format("Buffer %d: %s (Active: %s)", buf.number, buf.filename, buf.active))
--     end
--     if vim.fn.bufname() == "" and not vim.bo.modified then
--       vim.cmd.bwipeout()
--
--       local escaped_search = vim.fn.escape(search_text, [[/\]])
--       local escaped_replace = vim.fn.escape(replace_text, [[/\]])
--
--       -- Use the buffer range in the bufdo command
--       local cmd = string.format("%d,%dbufdo %%s/%s/%s/ge | update",
--         min_bufnr, max_bufnr,
--         escaped_search, escaped_replace)
--       vim.cmd(cmd)
--
--       print(string.format("Search and replace completed across buffers %d to %d.", min_bufnr, max_bufnr))
--     end
--     return
--   end
-- end



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
        ["<CR>"] = multi_select,
      },

      n = {
        ["<leader>qf"] = actions.smart_send_to_qflist + actions.open_qflist,
        --   ["<leader>sr"] = multi_find_and_replace,
      }
    },
  },
}
