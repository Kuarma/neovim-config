return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			"stevearc/conform.nvim",
			"mason-org/mason-lspconfig.nvim",
			"mason-org/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- Conform setup
			-- Docs: https://github.com/stevearc/conform.nvim/tree/master
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
			vim.keymap.set("n", "<leader>f", function()
				require("conform").format({ async = true })
			end, { desc = "Format current buffer" })
		end,
	},
}
