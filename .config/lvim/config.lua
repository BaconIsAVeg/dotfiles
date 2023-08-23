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
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
    end,
  }
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Toggle",
  t = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>ToggleTerm size=15 direction=horizontal<cr>", "Split horizontal" },
  s = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" },
  q = { "<cmd>call QuickFixToggle()<CR>", "Toggle Quick Fix List" },
  b = { "<cmd>GitBlameToggle<CR>", "Toggle Git Blame" },
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

vim.opt.foldmethod                             = "expr"
vim.opt.foldexpr                               = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel                              = 99
vim.opt.foldenable                             = true

lvim.builtin.which_key.setup.plugins.presets.z = true

lvim.builtin.project.detection_methods         = { "lsp", "pattern" }

lvim.builtin.treesitter.indent.disable         = false
lvim.builtin.treesitter.playground.enable      = true
lvim.builtin.treesitter.matchup.enable         = true
