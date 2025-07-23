-- Theme switching functionality
local M = {}

-- Function to read theme mode from file
local function read_theme_mode()
	local theme_file = vim.fn.expand("~/.theme-mode")
	if vim.fn.filereadable(theme_file) == 1 then
		local content = vim.fn.readfile(theme_file)[1]
		if content then
			return vim.trim(content)
		end
	end
	return nil
end

-- Function to set theme based on mode
function M.set_theme(mode)
	if mode == "light" then
		vim.cmd([[colorscheme catppuccin-latte]])
	else
		vim.cmd([[colorscheme tokyonight-night]])
		
		-- Custom highlight settings for line numbers (only for tokyonight)
		vim.cmd([[
			highlight LineNr guifg=#5eacd3
			highlight CursorLineNr guifg=#5eacd3
			highlight Comment guifg=#a9b1d6
		]])
	end
end

-- Initialize theme on startup
function M.init()
	-- Set initial theme based on file or default to dark
	local initial_theme = read_theme_mode() or "dark"
	M.set_theme(initial_theme)
	
	-- Create user commands for theme switching
	vim.api.nvim_create_user_command('ThemeDark', function()
		vim.fn.writefile({"dark"}, vim.fn.expand("~/.theme-mode"))
		M.set_theme("dark")
	end, {})
	
	vim.api.nvim_create_user_command('ThemeLight', function()
		vim.fn.writefile({"light"}, vim.fn.expand("~/.theme-mode"))
		M.set_theme("light")
	end, {})
end

return M