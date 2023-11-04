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

		-- vim.g.nvim_tree_special_files = {
		-- 	snow = {
		-- 		icon = " ", -- Replace 'customfiletype' with the actual file type
		-- 		color = "#b2b190", -- Replace with the desired color (optional)
		-- 	},
		-- }

		require("nvim-tree").setup({
			view = {
				adaptive_size = true,
				side = "right",
			},
		})

		vim.keymap.set("n", "<c-n>", ":NvimTreeFindFileToggle<CR>")
	end,
}
