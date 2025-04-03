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
		},
    {
			"<leader>fg",
			function() require('fzf-lua').live_grep() end,
			desc = "[F]ind [g]reppingl files in project dir"
		},
         {
			"<leader>fc",
            function() require('fzf-lua').files( {cwd=vim.fn.stdpath("config")}) end,
			desc = "[F]ind [c]onfig files to edit config settings"
		},
{
			"<leader>fk",
			"<cmd>FzfLua keymaps<CR>",
			desc = "[F]ind [k]emaps"
		},
        {
            "<leader>fb",
            function()
                require("fzf-lua").builtin()
            end,
            desc = "[F]ind [B]uiltin FZF",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").grep_cword()
            end,
            desc = "[F]ind current [W]ord",
        },
        {
            "<leader>fW",
            function()
                require("fzf-lua").grep_cWORD()
            end,
            desc = "[F]ind current [W]ORD",
        },
        {
            "<leader>fd",
            function()
                require("fzf-lua").diagnostics_document()
            end,
            desc = "[F]ind [D]iagnostics",
        },
        {
            "<leader>fr",
            function()
                require("fzf-lua").resume()
            end,
            desc = "[F]ind [R]esume",
        },
        {
            "<leader>fo",
            function()
                require("fzf-lua").oldfiles()
            end,
            desc = "[F]ind [O]ld Files",
        },
        {
            "<leader><leader>",
            function()
                require("fzf-lua").buffers()
            end,
            desc = "[,] Find existing buffers",
        },
        {
            "<leader>/",
            function()
                require("fzf-lua").lgrep_curbuf()
            end,
            desc = "[/] Live grep the current buffer",
        }

	}
}
