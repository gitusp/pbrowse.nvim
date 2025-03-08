if vim.g.loaded_pbrowse == 1 or vim.opt.compatible:get() then
  return
end

vim.g.loaded_pbrowse = 1
vim.g.loaded_pbrowse_health = 1

vim.api.nvim_create_user_command('PBrowse', function(opts)
  require('pbrowse').browse(opts.line1, opts.line2, opts.range)
end, {
  range = true
})
