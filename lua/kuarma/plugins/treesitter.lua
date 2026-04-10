local function select(textobj)
	return function()
		require("nvim-treesitter-textobjects.select").select_textobject(textobj, "textobjects")
	end
end

return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
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
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		init = function()
			local parser_installed = {
				"lua",
				"vim",
				"vimdoc",
				"editorconfig",
				"gitignore",
				"bash",
				"regex",
				"query",
				"markdown",
				"markdown_inline",
				"c_sharp",
				"xml",
				"sql",
				"json",
				"json5",
				"html",
				"css",
				"javascript",
				"latex",
				"scss",
				"svelte",
				"tsx",
				"typst",
				"vue",
			}

			vim.defer_fn(function()
				require("nvim-treesitter").install(parser_installed)
			end, 1000)
			require("nvim-treesitter").update()

			vim.api.nvim_create_autocmd("FileType", {
				desc = "User: enable treesitter highlighting",
				callback = function()
					local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
					if lang then
						pcall(vim.treesitter.start)
					else
						vim.notify("Parser not found")
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		branch = "main",
		opts = {
			select = {
				lookahead = true,
				include_surrounding_whitespace = false,
			},
		},
		keys = {
			{ "a<CR>", select("@return.outer"), mode = { "x", "o" }, desc = "↩ outer return" },
			{ "i<CR>", select("@return.inner"), mode = { "x", "o" }, desc = "↩ inner return" },
			{ "aa", select("@parameter.outer"), mode = { "x", "o" }, desc = "󰏪 outer arg" },
			{ "ia", select("@parameter.inner"), mode = { "x", "o" }, desc = "󰏪 inner arg" },
			{ "iu", select("@loop.inner"), mode = { "x", "o" }, desc = "󰛤 inner loop" },
			{ "au", select("@loop.outer"), mode = { "x", "o" }, desc = "󰛤 outer loop" },
			{ "al", select("@call.outer"), mode = { "x", "o" }, desc = "󰡱 outer call" },
			{ "il", select("@call.inner"), mode = { "x", "o" }, desc = "󰡱 inner call" },
			{ "af", select("@function.outer"), mode = { "x", "o" }, desc = " outer function" },
			{ "if", select("@function.inner"), mode = { "x", "o" }, desc = " inner function" },
			{ "ao", select("@conditional.outer"), mode = { "x", "o" }, desc = "󱕆 outer condition" },
			{ "io", select("@conditional.inner"), mode = { "x", "o" }, desc = "󱕆 inner condition" },
		},
	},
}
