return { 
    "ahmedkhalf/project.nvim",
    config = function()
    require("project_nvim").setup { {
        -- Manual mode doesn't automatically change your root directory, so you
        -- have the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native
        -- neovim lsp, while **"pattern"** uses vim-rooter like glob pattern
        -- matching. Here order matters: if one is not detected, the other is
        -- used as fallback. You can also delete or rearangne the detection
        -- methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile",
            "package.json" },

        -- Table of lsp clients to ignore by name eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories Ex: { "~/.cargo/*",
        -- ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes
        -- your directory.
        silent_chdir = true,

        -- What scope to change the directory, valid options are * global
        -- (default) * tab * win
        scope_chdir = 'global',

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"), } }
        -- Absolutely minimal implementation of fzf-lua based project finder
        -- for fzf-lua, due to request from @KrisWilliams1 (Maybe extended to a
        -- full blown port from the original selector in the future)
        local history = require("project_nvim.utils.history") local project =
        require("project_nvim.project")

        vim.api.nvim_create_user_command("FzfProjects", function() local
            projects = history.get_recent_projects()

            require("fzf-lua").fzf_exec(projects, { prompt = "Projects> ",
                actions = { ["default"] = function(selected) if selected and
                    #selected > 0 then local project_path = selected[1] if
                        project.set_pwd(project_path, "fzf-lua") then
                        require("fzf-lua").files() end end end } }) end, {})
    end,
    keys = {
        {
            "<leader>fp", "<cmd>FzfProjects<CR>", desc="Find Recent Projects"
        }
    }

}
