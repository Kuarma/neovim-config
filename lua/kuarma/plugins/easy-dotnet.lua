return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap",
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
				},
				background_scanning = true,
				csproj_mappings = true,
				fsproj_mappings = true,
				picker = "telescope",
				new = {
					project = {
						prefix = "sln",
					},
				},
				projx_lsp = {
					enabled = true,
				},
				notifications = {
					handler = function(start_event)
						local spinner = require("easy-dotnet.ui-modules.spinner").new()
						spinner:start_spinner(start_event.job.name)
						return function(finished_event)
							spinner:stop_spinner(finished_event.result.text, finished_event.result.level)
						end
					end,
				},
				debugger = {
					bin_path = nil,
					auto_register_dap = true,
					console = "internalTerminal",
					mappings = {
						open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
					},
				},
				auto_bootstrap_namespace = {
					type = "file_scoped",
					enabled = true,
				},
				terminal = function(path, action, args, ctx)
					local commands = {
						run = function()
							return string.format("%s %s", ctx.cmd, args)
						end,
						test = function()
							return string.format("%s %s", ctx.cmd, args)
						end,
						restore = function()
							return string.format("%s %s", ctx.cmd, args)
						end,
						build = function()
							return string.format("%s %s", ctx.cmd, args)
						end,
						watch = function()
							return string.format("dotnet watch --project %s %s", path, args)
						end,
					}

					vim.keymap.set("n", "<leader>Dv", dotnet.project_view, { desc = "open project view" })
					vim.keymap.set("n", "<leader>Dr", dotnet.restore, { desc = "dotnet restore" })
					vim.keymap.set("n", "<leader>Dc", dotnet.clean, { desc = "dotnet clean" })
					vim.keymap.set(
						"n",
						"<leader>Dq",
						dotnet.build_quickfix,
						{ desc = "open errors in a quickfix list" }
					)
					vim.keymap.set("n", "<leader>Db", dotnet.build, { desc = "dotnet build" })
					vim.keymap.set("n", "<leader>Do", dotnet.outdated, { desc = "dotnet outdated" })
					vim.keymap.set("n", "<leader>Da", dotnet.add_package, { desc = "dotnet add package" })
					vim.keymap.set("n", "<leader>Dw", dotnet.watch, { desc = "dotnet watch" })
					vim.keymap.set("n", "<leader>DN", dotnet.new, { desc = "dotnet new template" })
					vim.keymap.set("n", "<leader>Ds", dotnet.secrets, { desc = "dotnet secrets" })

					local command = commands[action]() .. "\r"
					require("toggleterm").exec(command, nil, nil, nil, "float")
				end,
			})
		end,
	},
	{
		"angeljreyes/boilersharp.nvim",
		config = function()
			require("boilersharp").setup()
		end,
	},
}
