function! pbrowse#browse(line1, line2, count) abort
  " Get current PR URL using gh command
  let l:pr_url = trim(system('gh pr view --json url --jq .url'))
  if v:shell_error != 0
    echoerr "Failed to get PR URL. Make sure you're in a git repository with an active PR and gh CLI is installed."
    return
  endif

  " Get file path relative to git root
  let l:file_path = trim(system('git ls-files --full-name ' . shellescape(expand('%:p'))))
  
  " Create hash of the file path using sha256
  let l:file_hash = trim(system('echo -n "' . l:file_path . '" | shasum -a 256 | cut -d " " -f 1'))
  
  " Build the URL
  let l:url = l:pr_url . '/files#diff-' . l:file_hash
  
  " Add line information only if it's a selection or a specific line
  if a:count > 0
    if a:line1 == a:line2
      let l:url = l:url . 'R' . a:line1
    else
      let l:url = l:url . 'R' . a:line1 . '-R' . a:line2
    endif
  endif
  
  if has('mac')
    call system('open ' . shellescape(l:url))
  elseif has('unix')
    call system('xdg-open ' . shellescape(l:url))
  elseif has('win32') || has('win64')
    call system('start "" ' . shellescape(l:url))
  else
    echoerr "Unsupported platform for opening URL"
  endif
endfunction
