-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.timeoutlen = 250 -- or 500 (Default: 1000)
vim.g.transparent_background = true
vim.g.gitblame_enabled = 0
lvim.colorscheme = "dracula"

lvim.plugins = {
  {
    "dhruvasagar/vim-table-mode"
  },
  {
    "dracula/vim"
  },
  {
    "chaimleib/vim-renpy"
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = true,     -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors)
        end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
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

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
