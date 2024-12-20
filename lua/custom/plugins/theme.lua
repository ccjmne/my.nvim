return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
  opts = {
    -- Use colors.none to revert something's colour
    -- See available colours at: https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
    custom_highlights = function(colors)
      -- C = require('catppuccin.palettes').get_palette 'mocha'
      -- U = require 'catppuccin.utils.colors'
      return {
        LineNr = { fg = colors.overlay2 },
        NonText = { fg = colors.mantle, bg = colors.text },
        MiniTrailspace = { fg = colors.surface0, bg = colors.red },
        MiniStatuslineInactive = { fg = colors.overlay2 },
        TelescopeBorder = { fg = colors.surface0 },
        TelescopeMultiSelection = { fg = colors.yellow },
        TelescopePromptBorder = { fg = colors.surface2 },
        TelescopePromptPrefix = { fg = colors.blue },
        TelescopeSelectionCaret = { fg = colors.yellow, bg = colors.surface0 },
        TelescopeTitle = { fg = colors.blue },
      }
    end,
    show_end_of_buffer = true,
    -- default_integrations = true,
    --
    integrations = {
      -- alpha = true,
      -- aerial = true,
      dap = true,
      dap_ui = true,
      mason = true,
      -- neotree = true,
      -- notify = true,
      -- nvimtree = false,
      semantic_tokens = true,
      symbols_outline = true,
      telescope = true,
      -- ts_rainbow = false,
      which_key = true,
    },
  },
}
