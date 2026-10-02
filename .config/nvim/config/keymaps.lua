local fzf_map = {
    {
        "<leader>ff",
        "<cmd>FzfLua files<CR>",
        desc = "Find files in local directory.",
    },
    {
        "<leader>fb",
        "<cmd>FzfLua builtin<CR>",
        desc = "[F]ind [b]uiltin fzf commands.",
    },
    {
        "<leader>fg",
        function()
            require("fzf-lua").live_grep()
        end,
        desc = "[F]ind [g]reppingl files in project dir",
    },
    {
        "<leader>fc",
        function()
            require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
        end,
        desc = "[F]ind [c]onfig files to edit config settings",
    },
    {
        "<leader>fk",
        "<cmd>FzfLua keymaps<CR>",
        desc = "[F]ind [k]emaps",
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
    },
    {
        "<leader>lf",
        function()
            require("fzf-lua").lsp_document_symbols()
        end,
        desc = "[l]sp [f]ind document symbols",
    },
    {
        "<leader>ld",
        function()
            require("fzf-lua").lsp_definitions()
        end,
        desc = "[l]sp find [d]efinitions",
    },
}

local lsp_key_maps = {
    {
        "<leader>lf",
        function()
            vim.lsp.buf.format({ async = true })
        end,
        desc = "[L]sp [F]ormat the current buffer."
    },
    {
        "<leader>le",
        function()
            vim.diagnostic.open_float(0, { scope = "line" })
        end,
        desc = "[L]sp show [e]rror",
    }
}

local helper_key_maps = {
    {
        "]e",
        function()
            vim.diagnostic.jump({
                count = 1,
                float = true,
                severity = vim.diagnostic.severity.ERROR
            })
        end,
        { desc = "Jump to next diagnostic error." }
    },
    {
        "gl",
        function()
            vim.diagnostic.open_float()
        end,
        { desc = "Open floating diagnostic buffer" },
    },
    {
        "-",
        "<CMD>Oil --float<CR>",
        { desc = "Open parent directory." },
    },
    {
        "W",
        "<CMD>write<CR>",
        { desc = "Save even if w is W." },
        "c",
    }
}



local function set_keymaps(array_map, mode)
    mode = mode or "n"
    for _, val in ipairs(array_map) do
        if #val == 4 then
            vim.keymap.set(
                val[4],
                val[1],
                val[2],
                val[3])
        else
            vim.keymap.set(
                mode,
                val[1],
                val[2],
                val[3]
            )
        end
    end
end

set_keymaps(fzf_map)
set_keymaps(lsp_key_maps)
set_keymaps(helper_key_maps)



vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>fs", require("fzf-lua").lsp_document_symbols, "[F]ind Document [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>fws", require("fzf-lua").lsp_live_workspace_symbols, "[F]ind [W]orkspace [S]ymbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>cr", vim.lsp.buf.rename, "[C]ode Re[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end
})
