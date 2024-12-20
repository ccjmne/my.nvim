return {
  dir = '.',
  config = function()
    vim.api.nvim_create_user_command('Title', function(opts)
      local padchar = opts.fargs[1] or '='
      local lo, hi
      if opts.count == -1 then -- Normal mode, see https://www.petergundel.de/neovim/lua/hack/2023/12/17/get-neovim-mode-when-executing-a-command.html
        lo, hi = vim.fn.line '.', vim.fn.line '.'
      else
        _, lo = unpack(vim.fn.getpos "'<")
        _, hi = unpack(vim.fn.getpos "'>")
      end

      for i = lo, hi do
        local head = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]:gsub('%s*[%.=-]*$', '')
        local pad = (vim.bo.textwidth > 0 and vim.bo.textwidth or 80) - #head - 1 -- vim."bo" stands for Buffer Options
        if pad > 0 then
          vim.api.nvim_buf_set_lines(0, i - 1, i, false, { head .. ' ' .. string.rep(padchar, pad) })
        end
      end
    end, { range = true, nargs = '?' })
  end,
}
