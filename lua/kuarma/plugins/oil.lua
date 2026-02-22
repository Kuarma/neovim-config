return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand "%"
        path = path:gsub("oil://", "")

        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
		default_file_explorer = true,
		skip_confirm_for_simple_edits = true,
		promt_save_on_select_new_entry = false,
		cleanup_delay_ms = 2000,
		use_default_keymaps = true,
		watch_for_changes = true,
		delete_to_trash = true,
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
        },
      }
      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space> -", require("oil").toggle_float)
    end,
  },
{
    "JezerM/oil-lsp-diagnostics.nvim",
    dependencies = { "stevearc/oil.nvim" },
    opts = {}
},
{
  "benomahony/oil-git.nvim",
  dependencies = { "stevearc/oil.nvim" },
  -- No opts or config needed! Works automatically
}
}
