return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.icons" },
	init = function()
		require("lualine").setup({
			options = {
				theme = "tokyonight",
			},
		})
	end,
}
