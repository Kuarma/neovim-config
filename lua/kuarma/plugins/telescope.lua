return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "kevinhwang91/nvim-bqf", ft = "qf" },
		{
			"junegunn/fzf",
			run = function()
				vim.fn["fzf#install"]()
			end,
		},
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
	},
	config = function()
		local telescope, builtin, actions, action_layout =
			require("telescope"),
			require("telescope.builtin"),
			require("telescope.actions"),
			require("telescope.actions.layout")

		telescope.load_extension("media_files")
		telescope.load_extension("fzf")

		local fzf_opts = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}

		telescope.setup({
			pickers = {
				lsp_dynamic_workspace_symbols = {
					sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
				},
			},
			extensions = {
				media_files = {
					filetypes = {
						"png",
						"webp",
						"jpg",
						"jpeg",
					},
					find_cmd = "rg",
				},
			},
			defaults = {
				mappings = {
					i = {
						["<C-u>"] = false,
						["<c-d>"] = actions.delete_buffer + actions.move_to_top,
						["<M-p>"] = action_layout.toggle_preview,
					},
					n = {
						["<M-p>"] = action_layout.toggle_preview,
						["q"] = actions.close,
					},
				},
			},
		})

		telescope.load_extension("ui-select")

		local gs = {
			hidden = true,
			no_ignore = true,
			file_ignore_patterns = {
				".git/",
				"target/",
				"%.lock",
			},
		}

	    --stylua: ignore start
		vim.keymap.set("n", "<space>f", function()	builtin.find_files(gs) end, { desc = "Search files" })
		vim.keymap.set("n", "<space>z", function()	builtin.live_grep(gs) end, { desc = "Live grep" })
		vim.keymap.set("n", "<space>sk", function()	builtin.keymaps(gs)	end, { desc = "Keymaps" })
		vim.keymap.set("n", "<space>sg", function()	builtin.git_files(gs) end, { desc = "Git files" })
		vim.keymap.set("n", "<space>sb", function() builtin.buffers(gs)	end, { desc = "Find buffers" })
		vim.keymap.set("n", "<space>sH", function()	builtin.help_tags(gs) end, { desc = "Neovim documentation" })
    vim.keymap.set("n", "<space>si", "<cmd>Telescope media_files<cr>", { desc = "Media files" })
    vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Effectively Ctrl+f" })
		--stylua: ignore end,
	end,
}
