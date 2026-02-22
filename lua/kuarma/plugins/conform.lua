return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				c = { "clang-format" },
				cs = { "csharpier" },
				csproj = { "csharpier" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				go = { "gofmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				elixir = { "mix" },
			},
			formatters = {
				clang_format = {
					prepend_args = {
						"-style=file",
						"-fallback-style=LLVM",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>F", function()
			require("conform").format({
				lsp_format = "fallback",
				bufnr = 0,
			})
		end, { desc = "Conform: Manually Format" })
	end,
}
