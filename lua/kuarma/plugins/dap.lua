return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			icons = {
				expanded = "▾",
				collapsed = "▸",
				current_frame = "*",
			},
			layouts = {
				{
					elements = {
						{ id = "easy-dotnet_cpu", size = 0.5 },
						{ id = "easy-dotnet_mem", size = 0.5 },
					},
					size = 35, -- Width of the sidebar
					position = "right",
				},
			},

			controls = {
				enabled = true,
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},

			mappings = {
				expand = { "<CR>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},

			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					["close"] = { "q", "<Esc>" },
				},
			},
		})

		dap.defaults.fallback.external_terminal = {
			command = "alacritty",
			args = { "-e" },
		}

		vim.fn.sign_define("DapStopped", {
			text = "󰳟",
			texthl = "",
			linehl = "DapStopped",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpoint", {
			text = "🚩",
			texthl = "",
			linehl = "",
			numhl = "",
		})

		vim.keymap.set("n", "<F9>", function()
			dap.terminate()
			dap.clear_breakpoints()
		end, { desc = "Terminate and clear breakpoints" })

		vim.keymap.set("n", "<F1>", dapui.toggle, { desc = "Toggle Debug UI" })
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt)" })
		vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
		vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
		vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })

		-- .NET specific setup using `easy-dotnet`
		require("easy-dotnet.netcoredbg").register_dap_variables_viewer() -- special variables viewer specific for .NET
	end,
}
