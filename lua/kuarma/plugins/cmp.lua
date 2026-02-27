-- https://main.cmp.saghen.dev/recipes.html#mini-icons-lspkind
return {
	"saghen/blink.cmp",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", opts = {} },
		"onsails/lspkind.nvim",
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<S-tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "select_next", "fallback" },
			["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			["<A-space>"] = {
				function(cmp)
					cmp.show({ providers = { "snippets" } })
				end,
			},
		},
		completion = {
			signature = {
				window = {
					border = "single",
				},
			},
			documentation = {
				auto_show = true,
			},

			ghost_text = {
				enabled = true,
			},
		},

		sources = {
			enabled = true,
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			sorts = {
				"score",
				"sort_text",
				"label",
			},
		},
	},
	opts_extend = {
		"sources.default",
	},
}
