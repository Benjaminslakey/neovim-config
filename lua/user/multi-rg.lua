local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"

local flatten = vim.tbl_flatten

-- i would like to be able to do telescope
-- and have telescope do some filtering on files and some grepping

return function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ["l"] = "*.lua",
      ["v"] = "*.vim",
      ["n"] = "*.{vim,lua}",
      ["js"] = "*.js",
      ["json"] = "*.json",
      ["g"] = "*.go",
      ["gonly"] = "*.go !**pb* !**test* !**mocks*",
    }
  opts.pattern = opts.pattern or "%s"

  local custom_grep = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local prompt_split = vim.split(prompt, "  ")

      local args = { "rg" }
      if prompt_split[1] then
        table.insert(args, "-e")
        table.insert(args, prompt_split[1])
      end

      for i = 2, #prompt_split do
        if prompt_split[i] then

          local patterns
          if opts.shortcuts[prompt_split[i]] then
            patterns = vim.split(opts.shortcuts[prompt_split[i]], "%s+")
          else
            patterns = {prompt_split[i]}
          end

          for _, pattern in ipairs(patterns) do
            table.insert(args, "-g")
            table.insert(args, string.format(opts.pattern, pattern))
          end
        end
      end

      return flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Live Grep (with shortcuts)",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end
