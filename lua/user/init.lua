require("user.keymaps")
require("user.options")

local commonFileTypes = { "*.go", "*.py", "*.lua", "*.js", "*.yaml", "*.yml", "*.json", "*.proto", "*.env", "*.sh" }

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(event)
    local file = event.match
    local cwd = vim.fn.getcwd()
    if vim.startswith(file, cwd) and vim.bo[event.buf].modified then
      -- The file is in the current working directory and has unsaved changes
      vim.cmd("silent! write")
      print("Saved changes to: " .. file)
    end
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit"},
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})


-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    vim.cmd [[
      if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

-- toggle off to enable auto block comment insert for new lines
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = commonFileTypes,
	callback = function()
    vim.lsp.buf.format({ async = true })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    vim.lsp.codelens.refresh()
    end,
})


-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function()
-- 		vim.cmd("hi link illuminatedWord LspReferenceText")
-- 	end,
-- })

-- Use 'q' to quit from common plugins
--[[ vim.api.nvim_create_autocmd({ "FileType" }, { ]]
--[[   pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" }, ]]
--[[   callback = function() ]]
--[[     vim.cmd [[ ]]
--[[       nnoremap <silent> <buffer> q :close<CR>  ]]
--[[       set nobuflisted  ]]
--[[   end, ]]
--[[ }) ]]
--[[]]
--[[ -- Remove statusline and tabline when in Alpha ]]
--[[ vim.api.nvim_create_autocmd({ "User" }, { ]]
--[[   pattern = { "AlphaReady" }, ]]
--[[   callback = function() ]]
--[[     vim.cmd [[ ]]
--[[       set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]]
--[[       set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3 ]]
--[[   end, ]]
--[[ }) ]]
--[[]]
--[[ -- Set wrap and spell in markdown and gitcommit ]]
--[[ vim.api.nvim_create_autocmd({ "FileType" }, { ]]
--[[   pattern = { "gitcommit", "markdown" }, ]]
--[[   callback = function() ]]
--[[     vim.opt_local.wrap = true ]]
--[[     vim.opt_local.spell = true ]]
--[[   end, ]]
--[[ }) ]]
--[[]]
--[[ vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif" ]]
--[[]]
--[[ -- Fixes Autocomment ]]
--[[ vim.api.nvim_create_autocmd({ "BufWinEnter" }, { ]]
--[[   callback = function() ]]
--[[     vim.cmd "set formatoptions-=cro" ]]
--[[   end, ]]
--[[ }) ]]
--[[]]
--[[ -- Highlight Yanked Text ]]
--[[ vim.api.nvim_create_autocmd({ "TextYankPost" }, { ]]
--[[   callback = function() ]]
--[[     vim.highlight.on_yank { higroup = "Visual", timeout = 200 } ]]
--[[   end, ]]
--[[ }) ]]
