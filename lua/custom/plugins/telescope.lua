return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      -- build = 'make',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },

    -- Set vim.ui.select to Telescope
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- layout_config = { anchor = 'N' },
      defaults = {
        results_title = false,
        mappings = {
          i = { ['<c-space>'] = 'to_fuzzy_refine' },
        },
        borderchars = {
          -- prompt = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          -- results = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          -- preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
          prompt = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          results = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
          preview = { '▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
        },
        path_display = { 'smart' },
        -- sorting_strategy = 'bottom', -- display results top->bottom
        -- layout_config = {
        --   prompt_position = 'top', -- search bar at the top
        -- },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See https://github.com/nvim-telescope/telescope.nvim?tab=readme-ov-file#neovim-lsp-pickers
    -- TODO: Also use builtin.lsp_document_symbols
    -- TODO: Also use builtin.lsp_workspace_symbols

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

      -- stylua: ignore start
      vim.keymap.set('n', '<leader>sh', function() builtin.help_tags { preview_title = '' } end, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function() builtin.keymaps { preview_title = '' } end, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function() builtin.find_files { preview_title = '' } end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', function() builtin.builtin { preview_title = '' } end, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', function() builtin.grep_string { preview_title = '' } end, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', function() builtin.live_grep { preview_title = '' } end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', function() builtin.diagnostics { preview_title = '' } end, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', function() builtin.resume { preview_title = '' } end, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s-', function() builtin.oldfiles { preview_title = '' } end, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', function() builtin.buffers { preview_title = '' } end, { desc = '[ ] Find existing buffers' })
    -- stylua: ignore end

    vim.keymap.set('n', '<leader>s.f', function()
      builtin.find_files { find_command = { 'rg', '--files', '--hidden', '--glob=!.git' } }
    end, { desc = '[S]earch [.]idden [F]iles' })
    vim.keymap.set('n', '<leader>s.g', function()
      builtin.live_grep { additional_args = { '--hidden', '--glob=!.git' }, preview_title = '' }
    end, { desc = '[S]earch [.]idden files by [G]rep' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config', preview_title = '' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
