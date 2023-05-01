-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.api.nvim_exec(
  [[
  function SwitchShiftTabWidth(width)
      execute "set shiftwidth=" . a:width
      execute "set tabstop=" . a:width
      execute "set softtabstop=" . a:width
  endfunction

  command! -nargs=? SetTW :call SwitchShiftTabWidth(<f-args>)
]],
  false
)
