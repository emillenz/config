return {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"stylua",
			"shellcheck",
			"shfmt",
			"flake8",
			"rustfmt",
			"java-test",
			"java-debug-adapter",
		},
	},
}
