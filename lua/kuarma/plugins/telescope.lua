return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.2.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"olimorris/persisted.nvim",
		"nvim-telescope/telescope-dap.nvim",
	},
	config = function()
		local telescope = require("telescope")
		telescope.load_extension("fzf")
		local builtin = require("telescope.builtin")

		local gs = {
			hidden = true,
			no_ignore = true,
			file_ignore_patterns = {
				".git/",
				"target/",
				"%.lock",
			},
		}

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
		})

		-- Telescope
        --stylua: ignore start
		vim.keymap.set("n", "<space>f", function()	builtin.find_files(gs) end, { desc = "Search files" })
		vim.keymap.set("n", "<space>z", function()	builtin.live_grep(gs) end, { desc = "Live grep" })
		vim.keymap.set("n", "<space>sk", function()	builtin.keymaps(gs)	end, { desc = "Keymaps" })
		vim.keymap.set("n", "<space>sp", "<cmd>Telescope persisted<cr>", { desc = "Persisted: sessions" })
		vim.keymap.set("n", "<space>sg", function()	builtin.git_files(gs) end, { desc = "Git files" })
		vim.keymap.set("n", "<space>sb", function() builtin.buffers(gs)	end, { desc = "Find buffers" })
		vim.keymap.set("n", "<space>sH", function()	builtin.help_tags(gs) end, { desc = "Neovim documentation" })
        vim.keymap.set("n", "<space>si", "<cmd>Telescope media_files<cr>", { desc = "Media files" })
        vim.keymap.set("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Effectively Ctrl+f" })
		--stylua: ignore end
	end,
}
