return {
	"olimorris/persisted.nvim",
	event = "BufReadPre",
	opts = {
		save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
		use_git_branch = true,
		autoload = false,
		autosave = false,
		silent = true,
		follow_cwd = true,
		ignored_dirs = { "tmp", "s", ".config" },
		telescope = {
			reset_prompt_after_deletion = true,
		},
	},
	mappings = {
        --stylua: ignore start
		vim.keymap.set("n", "<leader>Sl", "<cmd>Telescope persisted<cr>", { desc = "Session: Load" }),
		vim.keymap.set("n", "<leader>Ss", "<cmd>Persisted save<cr><cmd>lua print('session saved')<cr>", { desc = "Session: Save" }),
		--stylua: ignore end
	},
}
