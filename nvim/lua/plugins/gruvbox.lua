return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        italic = {
          strings = true,
          comments = true,
          operators = false,
        },
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
