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
			"nvim-tree/nvim-web-devicons",
			"onsails/lspkind.nvim",
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
					default = {
						"easy-dotnet",
						"lsp",
						"snippets",
						"path",
					},
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
						direction_priority = {
							"s",
							"n",
						},
						min_width = 45,
						max_height = 30,
						border = "none",
						winblend = 0,
						scrollbar = false,
						draw = {
							components = {
								kind_icon = {
									text = function(ctx)
										local icon = ctx.kind_icon
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												icon = dev_icon
											end
										else
											icon = require("lspkind").symbol_map[ctx.kind] or ""
										end

										return icon .. ctx.icon_gap
									end,

									highlight = function(ctx)
										local hl = ctx.kind_hl
										if vim.tbl_contains({ "Path" }, ctx.source_name) then
											local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
											if dev_icon then
												hl = dev_hl
											end
										end
										return hl
									end,
								},
							},
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
