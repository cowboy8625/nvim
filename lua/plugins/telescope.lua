return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
			},
		})

		local builtin = require("telescope.builtin")

		local function find_files()
			builtin.find_files({
				layout_strategy = "vertical",
				layout_config = {
					prompt_position = "top",
					horizontal = { width = 0.9, height = 0.9 },
					vertical = { height = 0.9, width = 0.9 },
					preview_height = 0.7,
				},
			})
		end

		vim.keymap.set("n", "<c-p>", find_files, {})
		vim.keymap.set("n", "<Space><Space>", builtin.oldfiles, {})
		vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})
		vim.keymap.set("n", "<Space>ff", builtin.grep_string, {})
	end,
}
