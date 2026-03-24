return {
	{
		"saghen/blink.compat",
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"xzbdmw/colorful-menu.nvim",
		},
		version = "1.*",
		config = function()
			require("blink.cmp").setup({

				keymap = {
					preset = "default",
					["<S-tab>"] = { "select_prev", "fallback" },
					["<Tab>"] = { "select_next", "fallback" },
					["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
					["<A-space>"] = {
						function(cmp)
							cmp.show({
								providers = {
									"snippets",
								},
							})
						end,
					},
				},
				signature = { enabled = true },

				sources = {
					default = { "lsp", "easy-dotnet", "snippets", "path" },

					providers = {
						["easy-dotnet"] = {
							name = "easy-dotnet",
							enabled = true,
							module = "easy-dotnet.completion.blink",
							score_offset = 10000,
							async = true,
						},
					},
				},

				completion = {
					documentation = { auto_show = true },
					ghost_text = { enabled = true },

					list = {
						selection = {
							preselect = true,
							auto_insert = true,
						},
					},

					accept = {
						auto_brackets = { enabled = true },
					},

					menu = {
						enabled = true,
						auto_show = true,
						direction_priority = { "s", "n" },

						min_width = 45,
						max_height = 30,
						border = "none",
						winblend = 10,
						scrollbar = false,
						draw = {
							columns = { { "kind_icon" }, { "label", gap = 1 } },

							-- Definition for columns
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},

							treesitter = { "lsp" },
						},
					},
				},

				opts_extend = {
					"sources.default",
				},

				appearance = {
					nerd_font_variant = "mono",
					kind_icons = {
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "󰒓",
						Field = "󰜢",
						Variable = "󰆦",
						Class = "󱡠",
						Interface = "󱡠",
						Module = "󰅩",
						Property = "󰖷",
						Unit = "󰪚",
						Value = "󰦨",
						Enum = "󰦨",
						Keyword = "󰻾",
						Snippet = "✂",
						Color = "󰏘",
						File = "󰈔",
						Reference = "󰬲",
						Folder = "󰉋",
						EnumMember = "󰦨",
						Constant = "󰏿",
						Struct = "󱡠",
						Event = "󱐋",
						Operator = "󰪚",
						TypeParameter = "󰬛",
					},
				},

				cmdline = {
					enabled = true,

					completion = {
						menu = { auto_show = true },
						ghost_text = { enabled = true },
					},

					keymap = { preset = "inherit" },
					sources = { "buffer", "cmdline" },
				},

				fuzzy = {
					implementation = "prefer_rust_with_warning",
				},
			})
		end,
	},
}
