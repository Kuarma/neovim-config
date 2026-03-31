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
					["<Tab>"] = { "select_next", "fallback" },
					["<S-tab>"] = { "select_prev", "fallback" },
					["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
					["<A-space>"] = {
						function(cmp)
							cmp.show({})
						end,
					},
				},

				signature = {
					enabled = true,
					trigger = {
						enabled = true,
						show_on_keyword = true,
						show_on_insert = true,
					},
					window = {
						min_width = 5,
						border = "rounded",
						direction_priority = { "s" },
						show_documentation = true,
						treesitter_highlighting = true,
					},
				},

				sources = {
					default = {
						"easy-dotnet",
						"lsp",
						"snippets",
						"path",
						"omni",
					},
					providers = {
						["easy-dotnet"] = {
							name = "easy-dotnet",
							enabled = true,
							module = "easy-dotnet.completion.blink",
							score_offset = 10000,
							async = true,
						},
						["omni"] = {
							module = "blink.cmp.sources.complete_func",
							enabled = function()
								return vim.bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
							end,
							---@type blink.cmp.CompleteFuncOpts
							opts = {
								complete_func = function()
									return vim.bo.omnifunc
								end,
							},
						},
						["snippets"] = {
							module = "blink.cmp.sources.snippets",
							score_offset = -1,
							opts = {
								friendly_snippets = true,
								search_paths = { vim.fn.stdpath("config") .. "/snippets" },
								global_snippets = { "all" },
								extended_filetypes = {},
								clipboard_register = "+",
								use_label_description = true,
							},
						},
					},
				},

				completion = {
					documentation = {
						auto_show = true,
						treesitter_highlighting = true,
						window = {
							border = "rounded",
							min_width = 10,
							scrollbar = true,
							winblend = 0,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
					},
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
						align_to = "label",
						direction_priority = {
							"s",
							"n",
						},
						min_width = 45,
						max_height = 30,
						border = "rounded",
						winblend = 0,
						scrollbar = false,
						draw = {
							padding = 1,
							gap = 1,
							snippet_indicator = "~",
							treesitter = { "lsp" },
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

				appearance = {
					nerd_font_variant = "mono",
				},

				cmdline = {
					enabled = true,
					completion = {
						menu = { auto_show = true },
						ghost_text = { enabled = true },
					},
					keymap = { preset = "inherit" },
					sources = {
						"buffer",
						"cmdline",
					},
				},

				fuzzy = {
					implementation = "prefer_rust_with_warning",
					max_typos = function(keyword)
						return math.floor(#keyword / 4)
					end,
					frecency = {
						enabled = true,
						path = vim.fn.stdpath("state") .. "/blink/cmp/frecency.dat",
					},
					use_proximity = true,
					sorts = {
						"score",
						"sort_text",
					},
					prebuilt_binaries = {
						download = true,
					},
				},
			})
		end,
	},
}
