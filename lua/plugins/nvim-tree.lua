return {
	"nvim-tree/nvim-tree.lua",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				adaptive_size = true,
				side = "right",
			},
		})

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
	end,
}
