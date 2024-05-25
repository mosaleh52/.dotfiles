return {
  {
    --     "jellydn/CopilotChat.nvim",
    --     opts = {
    --       mode = "split", -- newbuffer or split  , default: newbuffer
    --     },
    --     build = function()
    --       vim.defer_fn(function()
    --         vim.cmd("UpdateRemotePlugins")
    --         vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
    --       end, 3000)
    --     end,
    --     event = "VeryLazy",
    --     keys = {
    --       { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
    --       { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    --     },
  },
  {
    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function()
        require("chatgpt").setup({
          -- A
          api_key_cmd = "echo -n MIzaSyDP5kHVIs5bSw9mwJFcjZUY7eloHFBDUqk",
          api_host_cmd = "echo -n my-openai-gemini-demo.vercel.app",
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
  },
}
