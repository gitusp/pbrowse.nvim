local M = {}

local function open_url(url)
  if vim.fn.has('mac') == 1 then
    vim.fn.system('open ' .. vim.fn.shellescape(url))
  elseif vim.fn.has('unix') == 1 then
    vim.fn.system('xdg-open ' .. vim.fn.shellescape(url))
  else
    vim.api.nvim_err_writeln("Unsupported platform for opening URL")
  end
end

function M.browse(line1, line2, range)
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.api.nvim_err_writeln("Windows is not supported. Please use WSL (Windows Subsystem for Linux) instead.")
    return
  end

  -- Get current PR URL using gh command
  local pr_url = vim.fn.trim(vim.fn.system('gh pr view --json url --jq .url'))
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("Failed to get PR URL. Make sure you're in a git repository with an active PR and gh CLI is installed.")
    return
  end
  local pr_files_url = pr_url .. '/files'

  -- Get relative path from the project root of current file
  local full_path = vim.fn.expand('%:p')
  local file_path = vim.fn.trim(vim.fn.system('git ls-files --full-name -- ' .. vim.fn.shellescape(full_path)))
  if vim.v.shell_error ~= 0 or file_path == "" then
    open_url(pr_files_url)
    return
  end

  -- Create hash of the file path using sha256
  local file_hash = vim.fn.sha256(file_path)
  
  -- Build the URL
  local url = pr_files_url .. '#diff-' .. file_hash
  
  -- Add line information only if it's a selection or a specific line
  if range > 0 then
    if line1 == line2 then
      url = url .. 'R' .. line1
    else
      url = url .. 'R' .. line1 .. '-R' .. line2
    end
  end
  
  open_url(url)
end

return M
