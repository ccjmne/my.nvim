vim.env.VIM = '/usr/bin/nvim'
vim.env.PATH = '/usr/local/bin/gpg:' .. vim.env.PATH

--[[

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.wrap = false

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', precedes = '<', extends = '>' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Scroll Up and center' })
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Scroll Down and center' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'tpope/vim-fugitive', -- The premier Vim plugin for Git, or perhaps the other way around
    config = function()
      -- Define a toggle function for a detailed Fugitive commit view
      vim.api.nvim_set_keymap('n', '<leader>gd', ':lua ToggleFugitiveDetailedView()<CR>', { noremap = true, silent = true })

      function ToggleFugitiveDetailedView()
        local current_buf = vim.fn.bufname '%'
        -- Only apply if currently in a Fugitive buffer showing a commit
        if current_buf:match '^fugitive://' then
          -- Retrieve the current commit hash
          local commit_hash = vim.fn.expand '%:t' -- Gets the file part of the fugitive buffer (commit hash)
          print(commit_hash)
          -- Reopen the same commit with additional signature and metadata details
          vim.cmd('Gedit ' .. commit_hash .. ' --show-signature')
        else
          print 'Not in a Fugitive commit view.'
        end
      end
    end,
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = { -- Lazily load plugin, which takes up to ~30ms
      { 'gS', '<Cmd>TSJSplit<CR>', desc = 'Split TSNode' },
      { 'gJ', '<Cmd>TSJJoin<CR>', desc = 'Join TSNode' },
    },
    config = function()
      require('treesj').setup { use_default_keymaps = false, max_join_length = 150 }
    end,
  },

  {
    'ggandor/leap.nvim',
    config = function()
      -- TODO: Use the more idiomatic Lazy "keys" and stuff, see https://github.com/ggandor/leap.nvim/issues/246
      vim.keymap.set({ 'n', 'x', 'o' }, 'ss', '<Plug>(leap)')
      require('leap').opts.safe_labels = {}
      require('leap').opts.preview_filter = function()
        return false
      end
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
      -- The below settings make Leap's highlighting closer to what you've been
      -- used to in Lightspeed.

      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
      -- vim.api.nvim_set_hl(0, 'LeapMatch', {
      --   -- For light themes, set to 'black' or similar.
      --   fg = 'white',
      --   bold = true,
      --   nocombine = true,
      -- })

      -- Deprecated option. Try it without this setting first, you might find
      -- you don't even miss it.
      -- require('leap').opts.highlight_unlabeled_phase_one_targets = true
      require('leap').opts.equivalence_classes = {
        ' \t\r\n',
        'aäàáâãā',
        'dḍ',
        'eëéèêē',
        'gǧğ',
        'hḥḫ',
        'iïīíìîı',
        'nñ',
        'oō',
        'sṣšß',
        'tṭ',
        'uúûüűū',
        'zẓ',
        '([{',
        ')]}',
        '\'"`',
      }
      -- If using the default mappings (`gs` for multi-window mode), you can
      -- map e.g. `gS` here.
      vim.keymap.set({ 'n', 'o' }, 'gs', function()
        require('leap.remote').action()
      end)

      vim.api.nvim_create_augroup('LeapRemote', {})
      vim.api.nvim_create_autocmd('User', {
        pattern = 'RemoteOperationDone',
        group = 'LeapRemote',
        callback = function(event)
          -- Do not paste if some special register was in use.
          if vim.v.operator == 'y' and event.data.register == '"' then
            vim.cmd 'normal! P'
          end
        end,
      })
      local default_text_objects = {
        'iw',
        'iW',
        'is',
        'ip',
        'i[',
        'i]',
        'i(',
        'i)',
        'ib',
        'i>',
        'i<',
        'it',
        'i{',
        'i}',
        'iB',
        'i"',
        "i'",
        'i`',
        'aw',
        'aW',
        'as',
        'ap',
        'a[',
        'a]',
        'a(',
        'a)',
        'ab',
        'a>',
        'a<',
        'at',
        'a{',
        'a}',
        'aB',
        'a"',
        "a'",
        'a`',
      }
      -- Create remote versions of all native text objects by inserting `r`
      -- into the middle (`iw` becomes `irw`, etc.):
      for _, tobj in ipairs(default_text_objects) do
        vim.keymap.set({ 'x', 'o' }, tobj:sub(1, 1) .. 'r' .. tobj:sub(2), function()
          require('leap.remote').action { input = tobj }
        end)
      end
    end,
  },

  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = {
      'tpope/vim-fugitive',
    },
    config = function()
      vim.g.flog_permanent_default_opts = { max_count = 2000 }
      -- See https://github.com/rbong/vim-flog/issues/142
      vim.api.nvim_create_autocmd('User', {
        pattern = { 'FlogUpdate' },
        callback = function()
          require('mini.trailspace').unhighlight()
        end,
      })
    end,
  },

  {
    'mbbill/undotree',
    event = 'VeryLazy',
    vim.keymap.set('n', '<leader>tu', '<CMD>UndotreeToggle<CR>', { desc = 'Toggle Undotree' }),
    config = function()
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_DiffCommand = 'git diff --no-index'
      vim.g.undotree_SplitWidth = 30
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'undotree' },
        callback = function()
          vim.keymap.set('n', 'gq', '<CMD>UndotreeToggle<CR>', { buffer = 0 })
        end,
      })
    end,
  },

  {
    'stevearc/oil.nvim',
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    config = function()
      local oil = require 'oil'
      local columns = {
        { name = 'icon', enabled = true },
        { name = 'permissions', enabled = false },
        { name = 'size', enabled = false },
        { name = 'mtime', enabled = false },
      }

      local function toggle_column(idx)
        columns[idx].enabled = not columns[idx].enabled
        local cols = {}
        for _, column in ipairs(columns) do
          if column.enabled then
            table.insert(cols, column.name)
          end
        end
        oil.set_columns(cols)
      end

      oil.setup {
        skip_confirm_for_simple_edits = true,
        columns = { 'icon' },
        keymaps = {
          ['gq'] = 'actions.close',
          ['gp'] = {
            desc = 'Toggle permissions',
            callback = function()
              toggle_column(2)
            end,
          },
          ['gs'] = {
            desc = 'Toggle size',
            callback = function()
              toggle_column(3)
            end,
          },
          ['gt'] = {
            desc = 'Toggle last modified time',
            callback = function()
              toggle_column(4)
            end,
          },
        },
      }
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      settings = {
        tsserver_format_options = {
          -- See https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts
          semicolons = 'remove',
          indentSize = 2, -- For some reason, it detects the indentSize (very) wrongly on any typescript buffer after the first?!
          baseindentSize = 2,
        },
      },
    },
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  { 'nvim-java/nvim-java', ft = 'java' },

  {
    -- Garbage collector that stops inactive LSP clients to free RAM
    'zeioth/garbage-day.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    opts = {},
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- stylua: ignore start
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', function() require('telescope.builtin').lsp_definitions { preview_title = '' } end, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', function() require('telescope.builtin').lsp_references { preview_title = '' } end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', function() require('telescope.builtin').lsp_implementations { preview_title = '' } end, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', function() require('telescope.builtin').lsp_type_definitions { preview_title = '' } end, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', function() require('telescope.builtin').lsp_document_symbols { preview_title = '' } end, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols { preview_title = '' } end, '[W]orkspace [S]ymbols')
          -- stylua: ignore end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        rust_analyzer = {
          settings = {
            ['rust_analyzer'] = {
              checkOnSave = {
                command = 'clippy',
              },
            },
          },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'lemminx', -- xml support
        -- 'eslint',
        -- 'harper-ls',
        'java-debug-adapter',
        -- 'java-test',
        -- 'jdtls',
        -- 'js-debug-adapter',
        -- 'lombok-nightly',
        -- 'lua-language-server',
        -- 'openjdk-17',
        -- 'rust-analyzer rust_analyzer',
        -- 'spring-boot-tools',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      -- require('lspconfig').eslint.setup {
      --   on_attach = function(client, bufnr)
      --     vim.api.nvim_create_autocmd('BufWritePre', {
      --       buffer = bufnr,
      --       command = 'EslintFixAll',
      --     })
      --   end,
      -- }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
          jdtls = function()
            require('java').setup {}
            require('lspconfig').jdtls.setup {}
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>tf',
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          print('Format-on-save ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
        end,
        mode = '',
        desc = '[T]oggle [F]ormat on save',
      },
    },
    -- init = function()
    --   vim.keymap.set('n', '<leader>tf', function()
    --     vim.g.disable_autoformat = not vim.g.disable_autoformat
    --     print('Format-on-save ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
    --   end, { desc = '[T]oggle [F]ormat on save' })
    -- end,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      -- local emojis = {}
      -- emojis.new = function()
      --   setmetatable({}, { __index = emojis })
      -- end
      -- emojis.get_trigger_characters = function()
      --   return { '/' }
      -- end
      -- emojis.complete = function(self, request, callback)
      --   local input = string.sub(request.context.cursor_before_line, request.offset - 1)
      --   local prefix = string.sub(request.context.cursor_before_line, 1, request.offset - 1)
      --
      --   if vim.startswith(input, '/') and (prefix == '/' or vim.endswith(prefix, ' /')) then
      --     local items = {
      --       {
      --         label = 'shrug',
      --         textEdit = {
      --           newText = '¯\\_(ツ)_/¯',
      --           range = {
      --             start = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 - #input },
      --             ['end'] = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 },
      --           },
      --         },
      --       },
      --       {
      --         label = 'flip',
      --         textEdit = {
      --           newText = '(╯°□°)╯︵ ┻━┻',
      --           range = {
      --             start = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 - #input },
      --             ['end'] = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 },
      --           },
      --         },
      --       },
      --       {
      --         label = 'unflip',
      --         textEdit = {
      --           newText = '┬─┬ノ( º _ ºノ)',
      --           range = {
      --             start = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 - #input },
      --             ['end'] = { line = request.context.cursor.row - 1, character = request.context.cursor.col - 1 },
      --           },
      --         },
      --       },
      --     }
      --     callback { items = items, isIncomplete = true }
      --   else
      --     callback { isIncomplete = false }
      --   end
      -- end
      -- cmp.register_source('emojis', emojis)
      --
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          -- { name = 'emojis' },
        },
      }
    end,
  },

  {
    'petertriho/cmp-git',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      -- options go here
    },
    init = function()
      table.insert(require('cmp').get_config().sources, { name = 'git' })
    end,
  },

  {
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
          TelescopeBorder = { fg = colors.surface0 },
          TelescopeMultiSelection = { fg = colors.yellow },
          TelescopePromptBorder = { fg = colors.surface2 },
          TelescopePromptPrefix = { fg = colors.blue },
          TelescopeSelectionCaret = { fg = colors.yellow, bg = colors.surface0 },
          TelescopeTitle = { fg = colors.blue },

          -- TelescopeBorder = { fg = colors.surface0, bg = colors.surface0 },
          -- TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
          -- TelescopePromptNormal = { bg = colors.surface0 },
          -- TelescopePromptPrefix = { fg = colors.mauve, bg = colors.surface0 },
          -- TelescopePreviewTitle = { fg = colors.surface0, bg = colors.surface0 },
          -- TelescopePromptTitle = { fg = colors.blue, bg = colors.surface0 },
          -- TelescopeResultsTitle = { fg = colors.surface0, bg = colors.surface0 },
          -- TelescopeSelection = { bg = colors.surface1 },

          -- DiffAdd = { bg = U.darken(C.green, 0.50, C.base) },
          -- DiffChange = { bg = U.darken(C.blue, 0.50, C.base) },
          -- DiffDelete = { bg = U.darken(C.red, 0.50, C.base) },
          -- DiffText = { bg = U.darken(C.blue, 0.50, C.base) },
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
        notify = true,
        -- nvimtree = false,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        -- ts_rainbow = false,
        which_key = true,
      },
    },
  },

  { 'tomtom/tcomment_vim' },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function()
      require('lsp_lines').setup()
      vim.diagnostic.config {
        virtual_text = false,
        virtual_lines = { only_current_line = false, highlight_whole_line = false },
      } -- TODO: Check whether I can display the diagnostic source tool
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
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

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = false }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  -- { -- Highlight, edit, and navigate code
  --   'nvim-treesitter/nvim-treesitter',
  --   build = ':TSUpdate',
  --   main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --   opts = {
  --     ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
  --     -- Autoinstall languages that are not installed
  --     auto_install = true,
  --     highlight = {
  --       enable = true,
  --       -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --       --  If you are experiencing weird indenting issues, add the language to
  --       --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  --       additional_vim_regex_highlighting = { 'ruby' },
  --     },
  --     indent = { enable = true, disable = { 'ruby' } },
  --   },
  --   -- There are additional nvim-treesitter modules that you can use to interact
  --   -- with nvim-treesitter. You should go explore a few and see what interests you:
  --   --
  --   --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- TODO: set vim.opt.colorcolumn when I open a file whose textwidth is set (or something)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
