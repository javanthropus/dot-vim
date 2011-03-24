" When diffing...
if &diff
  " Add a bottom scroll bar.
  set guioptions+=b
  " Set a wider width based on the number of windows needed.
  let &columns = (80 + &foldcolumn) * last_buffer_nr() + last_buffer_nr() - 1
endif

" Maximize the GUI vertically.
set lines=999
