return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"c",
				"lua",
				"rust",
				"ruby",
				"vim",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"html",
				"ocaml",
				"haskell",
				"sql",
			},

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
