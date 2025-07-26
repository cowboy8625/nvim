-- theme
vim.cmd.colorscheme("habamax")
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
-- For transparency
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

--=================================================================================================
--                             Color Scheme Switcher
--=================================================================================================

local colorschemes = vim.fn.getcompletion("", "color")
local current_index = 1

local function cycle_colorschemes()
  current_index = current_index + 1
  if current_index > #colorschemes then
    current_index = 1
  end
  local ok, _ = pcall(vim.cmd.colorscheme, colorschemes[current_index])
  if not ok then
    vim.notify("Failed to load colorscheme: " .. colorschemes[current_index], vim.log.levels.ERROR)
  else
    vim.notify("Colorscheme: " .. colorschemes[current_index])
  end
end

vim.keymap.set("n", "<leader>cc", cycle_colorschemes, { desc = "Cycle colorscheme" })
