return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{
							path = "${3rd}/luv/library",
							words = { "vim%.uv" },
						},
					},
				},
			},
			"stevearc/conform.nvim",
			"mason-org/mason-lspconfig.nvim",
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
			"lewis6991/gitsigns.nvim",
			"folke/trouble.nvim",
		},
		config = function()
			-- Lsp / Mason setup
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})

			require("mason-lspconfig").setup({
				automatic_enable = true,
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					{
						"lua-language-server",
						auto_update = true,
					},
					{
						"bash-language-server",
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

			vim.keymap.set("n", "<leader>t", function()
				local state = not vim.diagnostic.config().virtual_text
				vim.diagnostic.config({ virtual_text = state })
			end, { desc = "Toggle virtual text" })

			vim.keymap.set("n", "<leader>l", function()
				local state = not vim.diagnostic.config().virtual_lines
				vim.diagnostic.config({ virtual_lines = state })
			end, { desc = "Toggle virtual lines" })

			-- Conform setup
			-- Docs: https://github.com/stevearc/conform.nvim/tree/master
			local conform = require("conform")

			conform.setup({
				async = true,
				formatters_by_ft = {
					lua = { "stylua" },
					cs = { lsp_format = "fallback", "csharpier" },
					csproj = { lsp_format = "fallback", "csharpier" },
					["*"] = { "codespell" },
					["_"] = { "trim_whitespace" },
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
