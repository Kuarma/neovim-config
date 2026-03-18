return {
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("telescope").load_extension("bibtex")
		end,
	},
}
