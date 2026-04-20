return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {
				enabled = true,
				all_references = true,
				virt_text_pos = "eol",
				commented = false,
			},
		},
		{
			"igorlfs/nvim-dap-view",
			lazy = false,
			version = "1.*",
			opts = {},
		},
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"folke/lazydev.nvim",
		"ChristianChiarulli/neovim-codicons",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		local widgets = require("dap.ui.widgets")

		-- .NET specific setup using `easy-dotnet`
		require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

		dapui.setup({
			expand_lines = true,
			force_buffers = true,
			wrap = true,

			controls = {
				element = "breakpoints",
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

			icons = {
				expanded = "▼",
				collapsed = "▶",
				current_frame = "→",
			},

			render = {
				indent = 1,
				max_type_length = 80,
				max_value_lines = 50,
			},

			floating = {
				max_height = 0.9,
				max_width = 0.8,
				border = "rounded",
				mappings = {
					["close"] = { "q", "<Esc>" },
				},
			},

			mappings = {
				expand = { "<CR>", "l" },
				open = { "o" },
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},

			element_mappings = {
				breakpoints = {
					open = "<CR>",
					remove = "dd",
				},
			},

			layouts = {
				{
					elements = {
						{
							id = "console",
							size = 1,
						},
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{
							id = "scopes",
							size = 1,
						},
					},
					size = 40,
					position = "right",
				},
				{
					elements = {
						{ id = "breakpoints", size = 0.5 },
						{ id = "watches", size = 0.5 },
					},
					size = 5,
					position = "bottom",
				},
			},
		})

		vim.api.nvim_set_hl(0, "DapUIScope", {
			fg = "#00ff00",
		})

		vim.api.nvim_set_hl(0, "DapUIVariable", {
			fg = "#999999",
		})

		vim.fn.sign_define("DapStopped", {
			text = "󰳟",
			texthl = "DapStopped",
			numhl = "DapStopped",
		})

		vim.fn.sign_define("DapBreakpoint", {
			text = "🛑",
			texthl = "DapBreakpoint",
			numhl = "DapBreakpoint",
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

    --stylua: ignore start
		vim.keymap.set("n", "<F1>", dapui.toggle, { desc = "Toggle Debug UI" })
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<F10>", dap.terminate, { desc = "Terminate session" })
		vim.keymap.set({ "n", "v" }, "<C-t>", function() widgets.preview() end, { desc = "Show variable in preview window" })
    vim.keymap.set("n", "<leader>df", function() widgets.centered_float(widgets.frames, { border = "rounded", width = 100, height = 20, }) end, { desc = "View call stack" })
		vim.keymap.set("n", "<leader>dp", dapui.eval, { desc = "Evaluate expression under cursor" })
		vim.keymap.set({ "n", "v" }, "dP", function() widgets.hover() end, { desc = "Inspect variable under cursor" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.clear_breakpoints, { desc = "Clear breakpoints" })
		vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
		vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })
		vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
		--stylua: ignore stop
	end,
}
