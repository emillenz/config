return {
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-o>'",
          insert_line = "<C-o>g'",
          normal = "'",
          normal_cur = "''",
          normal_line = "g'",
          normal_cur_line = "g''",
          visual = "'",
          visual_line = "g'",
          delete = "d'",
          change = "c'",
          change_line = "cg'",
        },
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,               desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,               desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                                            desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,REVIEW,HACK,INPROG,BUG<cr>",   desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                                          desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,REVIEW,HACK,BUG,INPROG<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "ggandor/flit.nvim",
    keys = function()
      ---@type LazyKeys[]
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },

  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
    opts = {
      labels = { "a", "o", "e", "u", "i", "d", "h", "t", "n", "s" }, -- using dvorak-homerow
    },
  },
}
