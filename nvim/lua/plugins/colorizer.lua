-- ~/.config/nvim/lua/plugins/colorizer.lua
return {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    user_default_options = {
      names = false, -- don't colorize color names like "red"
      css = true,
      css_fn = true,
      tailwind = true,
      mode = "background", -- ← THIS gives VS Code–like preview
    },
  },
}
