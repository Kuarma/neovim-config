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
				enabled = true,
				preload_roslyn = true,
				roslynator_enabled = true,
				easy_dotnet_analyzer_enabled = true,
				auto_refresh_codelens = true,
				analyzer_assemblies = {},
				config = {},
			},
			debugger = {
				bin_path = nil,
				console = "integratedTerminal",
				apply_value_converters = true,
				auto_register_dap = true,
				mappings = {
					open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
				},
			},
			mappings = {
				get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
				peek_stack_trace_from_buffer = { lhs = "<leader>P", desc = "peek stack trace from buffer" },
				go_to_file = { lhs = "g", desc = "go to file" },
				peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
				expand = { lhs = "o", desc = "expand" },
				expand_node = { lhs = "E", desc = "expand node" },
				collapse_all = { lhs = "W", desc = "collapse all" },
				cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
			},
			new = {
				project = {
					prefix = "sln",
				},
			},
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				type = "file_scoped",
				enabled = true,
				use_clipboard_json = {
					behavior = "auto",
					register = "+",
				},
			},
			picker = "telescope",
			background_scanning = true,
			diagnostics = {
				default_severity = "error",
				setqflist = false,
			},
		})
		vim.api.nvim_create_user_command("Secrets", function()
			dotnet.secrets()
		end, {})
	end,
}
