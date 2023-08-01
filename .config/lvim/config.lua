-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.timeoutlen = 250 -- or 500 (Default: 1000)
lvim.colorscheme = "github_dark_tritanopia"

lvim.plugins = {
  {
    "dhruvasagar/vim-table-mode"
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        themeStyle = "dimmed",
        commentStyle = "NONE",
        keywordStyle = "NONE",
        functionStyle = "NONE",
        variableStyle = "NONE",
        options = {
          darken = {
            sidebars = { "qf", "vista_kind", "terminal", "packer" },
          }
        }
      })
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
    end,
  },
  {
    "folke/twilight.nvim",
    event = "BufRead",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
        },
        context = 20, -- amount of lines we will try to show around the current line
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      })
    end,
  },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Toggle",
  t = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>ToggleTerm size=15 direction=horizontal<cr>", "Split horizontal" },
  s = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" },
  q = { "<cmd>call QuickFixToggle()<CR>", "Toggle Quick Fix List" },
  b = { "<cmd>GitBlameToggle<CR>", "Toggle Git Blame" },
  w = { "<cmd>Twilight<CR>", "Toggle Twilight" },
  i = { "<cmd>IndentBlanklineToggle<CR>", "Toggle Indent Line" },
  x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
}

lvim.builtin.which_key.mappings["s"]["m"] = { "<cmd>Telescope marks<cr>", "Search Marks" }

vim.g.gitblame_enabled = 0
