return {
	"mfussenegger/nvim-dap",
	config = function()
		require("dapui").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		dap.listeners.after.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.after.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

		vim.keymap.set("n", "<leader>dt", ":DapToggleBreakpoint<CR>", {})
		vim.keymap.set("n", "<leader>dx", ":DapTerminate<CR>", {})
		vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", {})
	end,
}