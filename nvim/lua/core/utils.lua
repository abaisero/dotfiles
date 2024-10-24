local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

-- vim.cmd [[
--   function! OperateTag(lnum, tag)
--     let line = getline(a:lnum)
--     if strridx(line, a:tag) != -1
--         normal dd
--     else
--         let plnum = prevnonblank(a:lnum)
--         if &expandtab
--             let indents = repeat(' ', indent(plnum))
--         else
--             let indents = repeat("\t", plnum / &shiftwidth)
--         endif
--
--         call append(line('.')-1, indents.a:tag)
--         normal k
--         " :Commentary
--     endif
--
--     " Save file without any events
--     noautocmd write
--
--   endfunction
-- ]]

function M.operate_tag(lnum, tag)
  local line = vim.fn.getline(lnum)

  if (vim.fn.strridx(line, tag) ~= -1) then
    vim.cmd[[normal dd]]

  else
    local prev_lnum = vim.fn.prevnonblank(lnum)
    local indents

    if vim.fn.exists('&expandtab') then
      indents = vim.fn["repeat"](' ', vim.fn.indent(prev_lnum))
    else
      indents = vim.fn["repeat"]('\t', prev_lnum / vim.fn.shiftwidth())
    end

    vim.fn.append(lnum - 1, indents .. tag)
    vim.cmd[[normal k]]
  end

  -- TODO: noautocmd write -- save file without any events
  vim.cmd[[noautocmd write]]

end

return M
