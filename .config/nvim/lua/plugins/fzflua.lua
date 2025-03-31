return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { "echasnovski/mini.icons" },
  opts = {},
  keys = {
		{
			"<leader>ff",
			"<cmd>FzfLua files<CR>",
			desc = "Find files in local directory."
		},
{
			"<leader>fb",
			"<cmd>FzfLua builtin<CR>",
			desc = "[F]ind [b]uiltin fzf commands."
		}

	}
}
