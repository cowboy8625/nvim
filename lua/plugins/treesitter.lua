return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"c",
				"css",
				"glimmer",
				"haskell",
				"html",
				"javascript",
				"lua",
				"ocaml",
				"prisma",
				"python",
				"regex",
				"ruby",
				"ruby",
				"rust",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"verilog",
				"vim",
				"vim",
				"vimdoc",
				"yaml",
				"zig",
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
