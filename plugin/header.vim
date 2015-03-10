
let g:copyright='~/.vim/data/copyright'
let g:author='~/.vim/data/author'

function! InsertHeader(cs,c,ce)
  let l:cpr=expand(g:copyright)
  let l:tpl=readfile(l:cpr)
  let l:author=readfile(expand(g:author), "", "1")[0]
  let l:date=strftime("%b %d, %Y")
  let l:year=strftime("%Y")
  let l:filename=expand('%:t')
  let l:user=substitute(system('whoami'), '\n.*$', "", "")
  if v:shell_error
    let l:user="unknown"
  endif

  let l:curr = 0
  for line in l:tpl
    let line = substitute(line, '@C@', a:c, "")
    let line = substitute(line, '@CS@', a:cs, "")
    let line = substitute(line, '@CE@', a:ce, "")
    let line = substitute(line, '@DATE@', l:date, "")
    let line = substitute(line, '@YEAR@', l:year, "")
    let line = substitute(line, '@AUTHOR@', l:author, "")
    let line = substitute(line, '@FILENAME@', l:filename, "")
    let line = substitute(line, '@LOGIN@', l:user, "")
    exe append(l:curr, line)
    let l:curr = l:curr + 1
  endfor
endfunction

function! UpdateModtime()
  let l:date=strftime("%c")
  let l:num=search('Last modification: ', 'bnw')
  let l:curs=getpos('.')
  if l:num > 0
    exe l:num . 's/\(Last modification: \).*$/\1' .l:date . '/' 
    call setpos('.', l:curs)
  endif
endfunction

