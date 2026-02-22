return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		{ "<c-h>", "<Cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<Cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<Cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<Cmd><C-U>TmuxNavigateRight<cr>" },
	},
}
