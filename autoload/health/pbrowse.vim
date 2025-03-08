function! health#pbrowse#check() abort
  call v:lua.vim.health.start('pbrowse requirements')

  " Check if 'gh' command is available
  if executable('gh')
    call v:lua.vim.health.ok('Found GitHub CLI (gh) in path')
  else
    call v:lua.vim.health.error('GitHub CLI (gh) not found in path', {
          \ 'Install GitHub CLI from https://cli.github.com/',
          \ 'Make sure it is available in your PATH'
          \ })
  endif

  " Check if 'git' command is available
  if executable('git')
    call v:lua.vim.health.ok('Found Git in path')
  else
    call v:lua.vim.health.error('Git not found in path', {
          \ 'Install Git from https://git-scm.com/',
          \ 'Make sure it is available in your PATH'
          \ })
  endif

  " Check for hashing utility
  if executable('shasum')
    call v:lua.vim.health.ok('Found shasum in path')
  else
    call v:lua.vim.health.error('shasum not found in path', {
          \ 'Make sure coreutils are installed on your system'
          \ })
  endif

  " Check for browser opening capability
  if has('mac') && executable('open')
    call v:lua.vim.health.ok('Found open command for launching browser (macOS)')
  elseif has('unix') && executable('xdg-open')
    call v:lua.vim.health.ok('Found xdg-open command for launching browser (Unix/Linux)')
  elseif (has('win32') || has('win64'))
    call v:lua.vim.health.ok('Using start command for launching browser (Windows)')
  else
    call v:lua.vim.health.warn('Browser opening command not detected for this platform', {
          \ 'Make sure you have appropriate browser opener available:',
          \ '- macOS: open command',
          \ '- Linux: xdg-open command',
          \ '- Windows: start command'
          \ })
  endif
endfunction
