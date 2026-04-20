return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = { "nvim-dap-ui", {
				path = "${3rd}/luv/library",
				words = { "vim%.uv" },
			} },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/trouble.nvim",
				opts = {},
				cmd = "Trouble",
				keys = {
					{
						"<leader>xx",
						"<cmd>Trouble diagnostics toggle<cr>",
						desc = "Diagnostics (Trouble)",
					},
				},
			},
			{
				"smjonas/inc-rename.nvim",
				opts = {},
			},
			"folke/lazydev.nvim",
			"stevearc/conform.nvim",
			"neovim/nvim-lspconfig",
			"mason-org/mason-lspconfig.nvim",
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
			"lewis6991/gitsigns.nvim",
		},
		config = function()
			-- Lsp / Mason setup
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					{
						"lua-language-server",
						auto_update = true,
					},
					{
						"roslyn",
						auto_update = true,
					},
					{
						"netcoredbg",
						auto_update = true,
					},
					{
						"jsonls",
						auto_update = true,
					},
					{
						"oxfmt",
						auto_update = true,
					},
					{
						"marksman",
						auto_update = true,
					},
					{
						"stylua",
						auto_update = true,
					},
					{
						"codespell",
						auto_update = true,
					},
				},
			})

			require("mason-lspconfig").setup({})

			local capabilities = {
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			}

			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			-- Set global capabilities for all LSP servers
			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git" },
			})

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,

				severity_sort = true,
				update_in_insert = true,

				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
			})

			vim.keymap.set("n", "<leader>dt", function()
				local state = not vim.diagnostic.config().virtual_text
				vim.diagnostic.config({ virtual_text = state })
			end, { desc = "Toggle virtual text" })

			vim.keymap.set("n", "<leader>dl", function()
				local state = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = state })
			end, { desc = "Toggle virtual lines" })

			-- Conform setup
			-- Docs: https://github.com/stevearc/conform.nvim/tree/master
			local conform = require("conform")

			conform.setup({
				async = true,
				formatters_by_ft = {
					json = { "oxfmt" },
					json5 = { "oxfmt" },
					lua = { "stylua" },
					md = { "marksman" },
					cs = { lsp_format = "fallback" },
					csproj = { lsp_format = "fallback" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},

				format_after_save = {
					lsp_format = "fallback",
				},
			})

			vim.keymap.set("n", "<leader>F", function()
				require("conform").format({ async = true })
			end, { desc = "Format current buffer" })
		end,
	},
}
