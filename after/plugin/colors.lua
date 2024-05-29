function ColorMyEditor(color)
	color = color or "rose-pine"
	vim.cmd(string.format('colorscheme %s', color))
	
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyEditor()
