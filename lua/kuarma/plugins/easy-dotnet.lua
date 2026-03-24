return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local dotnet = require("easy-dotnet")

		dotnet.setup({
			lsp = {
				enabled = true, -- Enable builtin roslyn lsp
				preload_roslyn = true, -- Start loading roslyn before any buffer is opened
				roslynator_enabled = true, -- Automatically enable roslynator analyzer
				easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
				auto_refresh_codelens = true,
				analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
				config = {},
			},
			debugger = {
				bin_path = nil, -- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
				console = "integratedTerminal", -- Controls where the target app runs: "integratedTerminal" (Neovim buffer) or "externalTerminal" (OS window)
				apply_value_converters = true,
				auto_register_dap = true,
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},
			new = {
				project = {
					prefix = "sln", -- "sln" | "none"
				},
			},
			picker = "telescope",
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				type = "block_scoped", --block_scoped, file_scoped
				enabled = true,
				use_clipboard_json = {
					behavior = "prompt", --'auto' | 'prompt' | 'never',
					register = "+", -- which register to check
				},
			},
		})
		vim.api.nvim_create_user_command("Secrets", function()
			dotnet.secrets()
		end, {})
	end,
}
