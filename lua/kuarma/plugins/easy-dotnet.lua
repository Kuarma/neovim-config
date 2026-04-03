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
				bin_path = nil,
				console = "integratedTerminal", -- Controls where the target app runs: "integratedTerminal" (Neovim buffer) or "externalTerminal" (OS window)
				apply_value_converters = true,
				auto_register_dap = true,
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},

			projx_lsp = {
				enabled = true,
			},

			new = {
				project = {
					prefix = "sln",
				},
			},

			picker = "telescope",
			csproj_mappings = true,
			fsproj_mappings = true,
			background_scanning = true,

			auto_bootstrap_namespace = {
				type = "file_scoped", --block_scoped, file_scoped
				enabled = true,
			},
		})

		vim.keymap.set("n", "<leader>Dv", dotnet.project_view, { desc = "open project view" })
		vim.keymap.set("n", "<leader>Dr", dotnet.restore, { desc = "dotnet restore" })
		vim.keymap.set("n", "<leader>Dc", dotnet.clean, { desc = "dotnet clean" })
		vim.keymap.set("n", "<leader>Dq", dotnet.build_quickfix, { desc = "open errors in a quickfix list" })
		vim.keymap.set("n", "<leader>Db", dotnet.build, { desc = "dotnet build" })
		vim.keymap.set("n", "<leader>Do", dotnet.outdated, { desc = "dotnet outdated" })
		vim.keymap.set("n", "<leader>Da", dotnet.add_package, { desc = "dotnet add package" })
		vim.keymap.set("n", "<leader>Dw", dotnet.watch, { desc = "dotnet watch" })
		vim.keymap.set("n", "<leader>DN", dotnet.new, { desc = "dotnet new template" })
		vim.keymap.set("n", "<leader>Ds", dotnet.secrets, { desc = "dotnet secrets" })
	end,
}
