vim.api.nvim_create_user_command("AddPlugin", function(opts)
  local input = opts.args
  local username, project = string.match(input, "([^/]+)/([^/]+)")
  if not username or not project then
    print("❗ Usage: ClonePlugin username/project")
    return
  end

  local target_dir = vim.fn.stdpath("config") .. "/pack/plugins/start/" .. project

  if vim.fn.isdirectory(target_dir) == 1 then
    print("✅ Plugin already exists: " .. target_dir)
    return
  end

  local repo_url = "https://github.com/" .. username .. "/" .. project .. ".git"
  print("📦 Cloning from: " .. repo_url)

  local cmd = string.format("git clone %s %s", vim.fn.shellescape(repo_url), vim.fn.shellescape(target_dir))
  local result = os.execute(cmd)

  if result == 0 then
    print("🎉 Plugin cloned into: " .. target_dir)
  else
    print("❌ Failed to clone plugin")
  end
end, {
  nargs = 1,
  complete = function(_, _)
    -- TODO: optionally implement completion, e.g., from your clipboard history or known repos
    return {}
  end,
  desc = "Clone a plugin from GitHub into pack/plugins/start",
})
