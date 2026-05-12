return {
	"seblyng/roslyn.nvim",
	-- Maintainer explicitly recommends NOT lazy-loading roslyn.nvim. Lazy/ft
	-- loading races against the razor cohost flow: when format-on-save fires
	-- it forwards a request to the html LSP via a virtual `__virtual.html`
	-- buffer, and if the html LSP hasn't attached yet the coroutine in
	-- htmlDocument:lspRequest never resumes -> `:w` hangs ~15s and times out.
	-- See https://github.com/seblyng/roslyn.nvim/issues/331
	lazy = false,
	opts = {},
}
