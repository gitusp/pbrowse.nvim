if exists('g:loaded_pbrowse') || &cp
  finish
endif
let g:loaded_pbrowse = 1

command! -range -nargs=? PBrowse call pbrowse#browse(<line1>, <line2>)
