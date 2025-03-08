local M = {}

function M.check()
  vim.health.start("pbrowse requirements")

  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.health.error('Windows is not supported', {
      'Please use WSL (Windows Subsystem for Linux) instead'
    })
    return
  end

  -- Check if 'gh' command is available
  if vim.fn.executable('gh') == 1 then
    vim.health.ok('Found GitHub CLI (gh) in path')
  else
    vim.health.error('GitHub CLI (gh) not found in path', {
      'Install GitHub CLI from https://cli.github.com/',
      'Make sure it is available in your PATH'
    })
  end

  -- Check if 'git' command is available
  if vim.fn.executable('git') == 1 then
    vim.health.ok('Found Git in path')
  else
    vim.health.error('Git not found in path', {
      'Install Git from https://git-scm.com/',
      'Make sure it is available in your PATH'
    })
  end

  -- Check for browser opening capability
  if vim.fn.has('mac') == 1 and vim.fn.executable('open') == 1 then
    vim.health.ok('Found open command for launching browser (macOS)')
  elseif vim.fn.has('unix') == 1 and vim.fn.executable('xdg-open') == 1 then
    vim.health.ok('Found xdg-open command for launching browser (Unix/Linux)')
  else
    vim.health.warn('Browser opening command not detected for this platform', {
      'Make sure you have appropriate browser opener available:',
      '- macOS: open command',
      '- Linux: xdg-open command'
    })
  end
end

return M
