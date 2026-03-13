return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				-- Rust: cargo install --locked tree-sitter-cli
				-- https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md
				auto_install = true,
				highlight = {
					enable = true,
				},
			})

			local ensure_installed = {
				"bash",
				"comment",
				"css",
				"diff",
				"dockerfile",
				"elixir",
				"git_config",
				"gitcommit",
				"latex",
				"gitignore",
				"groovy",
				"go",
				"heex",
				"hcl",
				"html",
				"http",
				"java",
				"javascript",
				"jsdoc",
				"json",
				"rust",
				"json5",
				"lua",
				"c_sharp",
				"make",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"rst",
				"rust",
				"scss",
				"ssh_config",
				"sql",
				"terraform",
				"typst",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			}

			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
					if lang then
						pcall(vim.treesitter.start)
					else
						vim.notify("Parser not found")
					end

					vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.opt.foldmethod = "expr"
					vim.opt.foldlevel = 10
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
}
