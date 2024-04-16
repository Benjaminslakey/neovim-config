-- function ColorMyPencils(color)
-- 	color = color or 'tokyonight-moon'
-- 	vim.cmd.colorscheme(color)
--
-- 	-- Set transparent background
-- 	-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' }) -- This will mess up bufferline vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' }) end ColorMyPencils()
function DisableDiagHighlight()
  vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', {})
end

DisableDiagHighlight()
