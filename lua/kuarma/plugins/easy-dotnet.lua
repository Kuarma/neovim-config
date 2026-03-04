return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local dotnet = require("easy-dotnet")

		-- Options are not required
		dotnet.setup({
			lsp = {
				enabled = true,
				roslynator_enabled = true,
				analyzer_assemblies = {},
				config = {},
			},
			debugger = {
				bin_path = nil,
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
			---@param action "test" | "restore" | "build" | "run"
			terminal = function(path, action, args)
				args = args or ""
				local commands = {
					run = function()
						return string.format("dotnet run --project %s %s", path, args)
					end,
					test = function()
						return string.format("dotnet test %s %s", path, args)
					end,
					restore = function()
						return string.format("dotnet restore %s %s", path, args)
					end,
					build = function()
						return string.format("dotnet build %s %s", path, args)
					end,
					watch = function()
						return string.format("dotnet watch --project %s %s", path, args)
					end,
				}
				local command = commands[action]()
				if require("easy-dotnet.extensions").isWindows() == true then
					command = command .. "\r"
				end
				vim.cmd("vsplit")
				vim.cmd("term " .. command)
			end,
			csproj_mappings = true,
			fsproj_mappings = true,
			auto_bootstrap_namespace = {
				type = "block_scoped",
				enabled = true,
				use_clipboard_json = {
					behavior = "prompt",
					register = "+",
				},
			},
			server = {
				---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
				log_level = "All",
			},
			picker = "telescope",
			background_scanning = true,
			notifications = {
				--Set this to false if you have configured lualine to avoid double logging
				handler = function(start_event)
					local spinner = require("easy-dotnet.ui-modules.spinner").new()
					spinner:start_spinner(start_event.job.name)
					return function(finished_event)
						spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
					end
				end,
			},
			diagnostics = {
				default_severity = "error",
				setqflist = false,
			},
		})

		vim.api.nvim_create_user_command("Secrets", function()
			dotnet.secrets()
		end, {})

		vim.keymap.set("n", "<leader>Cv", function()
			dotnet.project_view()
		end, { desc = "Dotnet project view" })
	end,
}
