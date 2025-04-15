return {
	"civitasv/cmake-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		cmake_generate_options = {
			"-DCMAKE_EXPORT_COMPILE_COMMANDS=1",
			"-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
		},
		cmake_build_directory = function()
			local root, method = require("project_nvim.project").get_project_root()
			return root .. "/build/${variant:buildType}"
		end,
	},
}
