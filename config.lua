-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- general
lvim.transparent_window = true
lvim.format_on_save = true

-- nav mapping
lvim.keys.normal_mode["<Up>"] = "<C-w>k"
lvim.keys.normal_mode["<Down>"] = "<C-w>j"
lvim.keys.normal_mode["<Left>"] = "<C-w>h"
lvim.keys.normal_mode["<Right>"] = "<C-w>l"

-- resize with shift + arrow
lvim.keys.normal_mode["<S-Up>"] = "<cmd>resize +2<CR>"
lvim.keys.normal_mode["<S-Down>"] = "<cmd>resize -2<CR>"
lvim.keys.normal_mode["<S-Right>"] = "<cmd>vertical resize +5<CR>"
lvim.keys.normal_mode["<S-Left>"] = "<cmd>vertical resize -5<CR>"

-- overseer
lvim.builtin.which_key.mappings['o'] = {
  name = "Overseer",
  o = { "<cmd>OverseerToggle right<cr>", "Toggle" },
  i = { "<cmd>OverseerInfo<cr>", "Info" },
  b = { "<cmd>OverseerBuild<cr>", "Build" },
  r = { "<cmd>OverseerRun<cr>", "Run" },
  c = { "<cmd>OverseerRunCmd<cr>", "Cmd" },
  a = { "<cmd>OverseerTaskAction<cr>", "Cmd" },
}

-- plugins
lvim.plugins = {
  { "github/copilot.vim", lazy = false },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "axelvc/template-string.nvim",
    config = function() require("template-string").setup() end,
  },
  {
    "stevearc/overseer.nvim",
    opts = {},
    lazy = false,
    config = function() require("overseer").setup() end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
}

-- copilot accept remap
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"

lvim.builtin.cmp.mapping["<C-a>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end
