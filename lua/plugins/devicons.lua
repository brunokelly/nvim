-- lua/plugins/devicons.lua
return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    color_icons = true,
    override = {
      -- Extensão .lua
      },
  },
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)
  end,
}

