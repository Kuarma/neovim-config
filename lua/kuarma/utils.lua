local fn = vim.fn

local M = {}

function M.executable(name)
	return fn.executable(name) > 0
end

function M.create_dir(dir)
	local result = fn.isdirectory(dir)

	if result == 0 then
		fn.mkdir(dir, "p")
	end
end

function M.inside_git_repo()
	local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true }):wait()
	if result.code ~= 0 then
		return false
	end

	vim.cmd([[doautocmd User InGitRepo]])

	return true
end

return M
