function remove_numbers()
	vim.wo.number = not vim.wo.number
	vim.wo.relativenumber = not vim.wo.relativenumber
end

-- function normal_numbers()
--   vim.wo.number = true
--   vim.wo.relativenumber = not vim.wo.relativenumber
-- end

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("t", "<c-k>", "<c-\\><c-n>:wincmd k<CR>")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n>:wincmd j<CR>")
vim.keymap.set("t", "<c-h>", "<c-\\><c-n>:wincmd h<CR>")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n>:wincmd l<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Spawn terminal at bottom of screen
vim.keymap.set("n", "<leader>;", ":belowright split | term<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.keymap.set("n", "<leader>nln", remove_numbers)
-- vim.keymap.set('n', '<leader>nnn', normal_numbers)

vim.keymap.set("n", "<leader><CR>", ":so %<CR>")
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>")

vim.api.nvim_create_user_command("InsertDate", function()
	local currentDateTime = vim.fn.system("date")
	local trimmedDateTime = currentDateTime:gsub("^%s*(.-)%s*$", "%1")
	vim.api.nvim_put({ trimmedDateTime }, "c", true, true)
end, {})

vim.keymap.set("i", "<F5>", "<C-o>:InsertDate<CR>")
vim.keymap.set("n", "<F5>", ":InsertDate<CR>")

-- Define a custom function to scroll when close to the bottom
function ScrollOnBottom()
	-- Get the current cursor line number
	local cursor_line = vim.fn.line(".")

	-- Get the current window
	local win = vim.api.nvim_get_current_win()

	-- Get the height (number of lines) of the current window
	local win_height = vim.api.nvim_win_get_height(win)

	-- Define a threshold (adjust as needed)
	local threshold = 5

	-- Check if the cursor is close to the bottom
	if win_height - cursor_line < threshold then
		-- Scroll the screen up (adjust as needed)
		vim.cmd("normal! zz")
	end
end

-- Map a keybinding to trigger the custom function
vim.api.nvim_set_keymap("n", "<C-f>", ":lua ScrollOnBottom()<CR>", { noremap = true, silent = true })

-- vim.keymap.set('n', '<A-k>', ':m -2<CR>')
-- vim.keymap.set('n', '<A-j>', ':m +1<CR>')
