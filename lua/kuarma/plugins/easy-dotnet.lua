return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
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
			server = {
				---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				log_level = "Off",
				use_visual_studio = false,
			},
			test_runner = {
				enable_buffer_test_execution = true,
				viewmode = "float",
				noBuild = false,
				mappings = {
					run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
					get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
					peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
					debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
					debug_test = { lhs = "<leader>d", desc = "debug test" },
					go_to_file = { lhs = "g", desc = "go to file" },
					run_all = { lhs = "<leader>R", desc = "run all tests" },
					run = { lhs = "<leader>r", desc = "run test" },
					peek_stacktrace = { lhs = "<leader>s", desc = "peek stacktrace of failed test" },
					expand = { lhs = "o", desc = "expand" },
					expand_node = { lhs = "E", desc = "expand node" },
					collapse_all = { lhs = "W", desc = "collapse all" },
					close = { lhs = "q", desc = "close testrunner" },
					refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
					cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
				},
			},
			background_scanning = true,
			csproj_mappings = true,
			fsproj_mappings = true,
			new = {
				project = {
					prefix = "sln",
				},
			},
			projx_lsp = {
				enabled = true,
			},
			notifications = {
				handler = nil,
			},
			debugger = {
				bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason/bin/netcoredbg"),
				console = "integratedTerminal",
				-- console = "externalTerminal",
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},
			auto_bootstrap_namespace = {
				type = "file_scoped",
				enabled = true,
			},
		})
	end,
}
