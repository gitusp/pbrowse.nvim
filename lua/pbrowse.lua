local M = {}

local function open_url(url)
  if vim.fn.has('mac') == 1 then
    vim.system({ 'open', url })
  elseif vim.fn.has('unix') == 1 then
    vim.system({ 'xdg-open', url })
  else
    vim.notify("Unsupported platform for opening URL", vim.log.levels.ERROR)
  end
end

local function create_suffix(line1, line2)
  if line1 == line2 then
    return 'R' .. line1
  else
    return 'R' .. line1 .. '-R' .. line2
  end
end

function M.browse(line1, line2, range)
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.notify("Windows is not supported. Please use WSL (Windows Subsystem for Linux) instead.", vim.log.levels.ERROR)
    return
  end

  vim.notify("Fetching PR URL...", vim.log.levels.INFO)
  vim.system({ 'gh', 'pr', 'view', '--json', 'url', '--jq', '.url' }, nil, function(pr_view_result)
    if pr_view_result.code ~= 0 then
      vim.notify("Failed to get PR URL. Make sure you're in a git repository with an active PR and gh CLI is installed.", vim.log.levels.ERROR)
      return
    end

    local pr_url = vim.fn.trim(pr_view_result.stdout)
    local pr_files_url = pr_url .. '/files'

    local full_path = vim.fn.expand('%:p')
    vim.system({ 'git', 'ls-files', '--full-name', '--', full_path }, nil, function(ls_files_result)
      if ls_files_result.code ~= 0 then
        open_url(pr_files_url)
        return
      end

      local file_path = vim.fn.trim(ls_files_result.stdout)
      local file_hash = vim.fn.sha256(file_path)
      local suffix = range > 0 and create_suffix(line1, line2) or ''
      local url = pr_files_url .. '#diff-' .. file_hash .. suffix

      open_url(url)
    end)
  end)
end

return M
