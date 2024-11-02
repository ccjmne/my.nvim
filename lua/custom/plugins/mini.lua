return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- TODO: Consider dropping it?
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup()

      require('mini.align').setup()

      require('mini.trailspace').setup()

      local MiniDiff = require 'mini.diff'
      MiniDiff.setup {
        -- 'myers'|'minimal'|'patience'|'histogram'
        options = { algorithm = 'myers' },
        source = MiniDiff.gen_source.git(),
      }
      vim.keymap.set('n', '<leader>td', MiniDiff.toggle_overlay, { desc = 'MiniDiff: Toggle Overlay' })

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = false }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%l:%v'
      end
    end,
  },
}
