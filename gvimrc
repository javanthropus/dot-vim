" Show line numbers.
set number
highlight LineNr gui=NONE guifg=DarkRed guibg=LightGrey

" When diffing...
if &diff
  " Add a bottom scroll bar.
  set guioptions+=b
  " Set a wider width based on the number of windows needed.
  let &columns = (80 + &foldcolumn + &numberwidth) * last_buffer_nr() +
                 \ last_buffer_nr() - 1
else
  " Ensure that there are 80 columns for buffer contents even when line numbers
  " are displayed.
  let &columns = 80 + &numberwidth
endif

" Maximize the GUI vertically.
set lines=999
