return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},

			on_attach = function()
				local gitsigns = require("gitsigns")

				-- Navigation
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				vim.keymap.set("n", "<leader>Gs", gitsigns.stage_hunk, { desc = "Stage selection" })
				vim.keymap.set("n", "<leader>Gr", gitsigns.reset_hunk, { desc = "Reset selection" })

				vim.keymap.set("v", "<leader>Gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage selection" })

				vim.keymap.set("v", "<leader>Gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset selection" })

				vim.keymap.set("n", "<leader>GS", gitsigns.stage_buffer, { desc = "Stage buffer" })
				vim.keymap.set("n", "<leader>GR", gitsigns.reset_buffer, { desc = "Reset buffer" })
				vim.keymap.set("n", "<leader>Gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
				vim.keymap.set("n", "<leader>Gi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

				vim.keymap.set("n", "<leader>Gb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Git blame" })

				vim.keymap.set("n", "<leader>Gd", gitsigns.diffthis, { desc = "Git diff" })

				vim.keymap.set("n", "<leader>GQ", function()
					gitsigns.setqflist("all")
				end, { desc = "Git quickfix project" })
				vim.keymap.set("n", "<leader>Gq", gitsigns.setqflist, { desc = "Git quickfix current file" })

				-- Toggles
				vim.keymap.set(
					"n",
					"<leader>Tb",
					gitsigns.toggle_current_line_blame,
					{ desc = "Git toggle current line blame" }
				)
				vim.keymap.set("n", "<leader>Tw", gitsigns.toggle_word_diff, { desc = "Git toggle word diff" })
			end,
		})
	end,
}
