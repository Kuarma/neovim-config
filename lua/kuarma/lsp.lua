local capabilities = {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.fn.sign_define("DapBreakpoint", {
	text = "🔴",
})

vim.lsp.config("*", {
	capabilities = capabilities,
})

vim.diagnostic.config({
	virtual_lines = {
		enabled = true,
		spacing = 2,
	},

	severity_sort = true,
	update_in_insert = true,
})
