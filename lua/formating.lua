-- ================================================================================================
--                                       Formatting
-- ================================================================================================

local function format_code()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local filetype = vim.bo[bufnr].filetype
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  if filename == "" then
    print("Save the file first before formatting.")
    return
  end

  local formatters = {
    python = {
      cmd = function(fname)
        return "black --quiet " .. vim.fn.shellescape(fname)
      end,
      post_process = function()
        vim.cmd("checktime")
      end,
    },
    sh = {
      cmd = function()
        return { "shfmt", "-i", "2", "-ci", "-sr" }
      end,
      use_stdin = true,
    },
    lua = {
      cmd = function(fname)
        return "stylua --indent-width 2 --indent-type Spaces " .. vim.fn.shellescape(fname)
      end,
      post_process = function()
        vim.cmd("checktime")
      end,
    },
    zig = {
      cmd = function(fname)
        return "zig fmt " .. vim.fn.shellescape(fname)
      end,
      post_process = function()
        vim.cmd("checktime")
      end,
    },
    rust = {
      cmd = function()
        return "cargo fmt "
      end,
      post_process = function()
        vim.cmd("checktime")
      end,
    },
  }

  local formatter = formatters[filetype]

  if not formatter then
    print("No formatter configured for " .. filetype)
    return
  end

  if formatter.use_stdin then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local content = table.concat(lines, "\n")
    local result = vim.fn.system(formatter.cmd(), content)

    if vim.v.shell_error == 0 then
      local formatted_lines = vim.split(result, "\n")
      if formatted_lines[#formatted_lines] == "" then
        table.remove(formatted_lines)
      end
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
      vim.api.nvim_win_set_cursor(0, cursor_pos)
    else
      print(filetype .. " formatter error: " .. result)
    end
  else
    local cmd = formatter.cmd(filename)
    local result = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
      if formatter.post_process then
        formatter.post_process()
      end
      vim.api.nvim_win_set_cursor(0, cursor_pos)
    else
      print(filetype .. " formatter error: " .. result)
    end
  end
end

vim.api.nvim_create_user_command("FormatCode", format_code, {
  desc = "Format current file",
})

vim.keymap.set("n", "<leader>fm", format_code, { desc = "Format file" })

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = format_code,
})
