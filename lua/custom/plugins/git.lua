return {
  'tpope/vim-fugitive', -- The premier Vim plugin for Git, or perhaps the other way around

  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = { 'tpope/vim-fugitive' },
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
}
