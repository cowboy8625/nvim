return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local status, mason = pcall(require, "mason")
		if not status then
			return
		end
		local status2, lspconfig = pcall(require, "mason-lspconfig")
		if not status2 then
			return
		end

		mason.setup()
		lspconfig.setup({
			ensure_installed = {
				"lua_ls",
			},
		})

		vim.api.nvim_create_user_command("ToggleDiagnostics", function(global)
			local vars, bufnr, cmd
			if global then
				vars = vim.g
				bufnr = nil
			else
				vars = vim.b
				bufnr = 0
			end
			vars.diagnostics_disabled = not vars.diagnostics_disabled
			if vars.diagnostics_disabled then
				cmd = "disable"
				vim.api.nvim_echo({ { "Disabling diagnostics…" } }, false, {})
			else
				cmd = "enable"
				vim.api.nvim_echo({ { "Enabling diagnostics…" } }, false, {})
			end
			vim.schedule(function()
				vim.diagnostic[cmd](bufnr)
			end)
		end, {})

		local on_attach = function(_, bufnr)
			if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
				vim.diagnostic.disable(bufnr)
			end
			vim.keymap.set("n", "<leader>td", ":ToggleDiagnostics", {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		require("lspconfig").sqlls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				SQL = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/sql")] = true,
							[vim.fn.stdpath("config") .. "/sql"] = true,
						},
					},
				},
			},
		})

		-- require("lspconfig").solargraph.setup({
		--   on_attach = on_attach,
		--   capabilities = capabilities,
		-- })

		require("lspconfig").cssls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- require("lspconfig").denols.setup({
		--   on_attach = on_attach,
		--   capabilities = capabilities,
		--   settings = {
		--     Typescript = {
		--       diagnostics = {
		--         globals = { "vim" },
		--       },
		--       workspace = {
		--         library = {
		--           [vim.fn.expand "$VIMRUNTIME/typescript"] = true,
		--           [vim.fn.stdpath "config" .. "/ts"] = true,
		--         },
		--       },
		--     },
		--   }
		-- })

		require("lspconfig").tsserver.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				JavaScripts = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/javascript")] = true,
							[vim.fn.stdpath("config") .. "/js"] = true,
						},
					},
				},
			},
		})
		require("lspconfig").eslint.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				JavaScripts = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/javascript")] = true,
							[vim.fn.stdpath("config") .. "/js"] = true,
						},
					},
				},
			},
		})
		require("lspconfig").swift_mesonls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				JavaScripts = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/swift")] = true,
							[vim.fn.stdpath("config") .. "/swift"] = true,
						},
					},
				},
			},
		})
		require("lspconfig").zls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				JavaScripts = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/zig")] = true,
							[vim.fn.stdpath("config") .. "/zig"] = true,
						},
					},
				},
			},
		})
	end,
}

-- require("lspconfig").prismals.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })

-- require("lspconfig").ember.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
-- })
-- }
