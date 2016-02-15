let s:save_cpo = &cpo
set cpo&vim

function! operator#markdown#right_header(motion_wise) abort
  let start_l = getpos("'[")[1]
  let end_l   = getpos("']")[1]

  let line = start_l

  while line <= end_l
    let t = s:header_type(line)

    if t == ''
      let line += 1
      continue
    endif

    let v = getline(line)
    if t == '#'
      call setline(line, '#' . v)
    elseif t == '='
      let x = getline(line+1)
      call setline(line+1, substitute(x, '.', '-', 'g'))
    elseif t == '-'
      call setline(line, '### ' . v)
      execute string(line+1) . 'delete'
      normal! k
      let end_l -= 1
    endif

    let line += 1
  endwhile

  return
endfunction


" TODO: DRY
function! operator#markdown#left_header(motion_wise) abort
  let start_l = getpos("'[")[1]
  let end_l   = getpos("']")[1]

  let line = start_l

  while line <= end_l
    let t = s:header_type(line)

    if t == ''
      let line += 1
      continue
    endif

    let v = getline(line)
    if t == '#'
      call setline(line, v[1:])
    elseif t == '='
      " なにもしない
    elseif t == '-'
      let x = getline(line+1)
      call setline(line+1, substitute(x, '.', '=', 'g'))
    endif

    let line += 1
  endwhile

  return
endfunction

function! s:header_type(line) abort
  let v = getline(a:line)
  if v =~ '^\V#\.'
    return '#'
  endif

  if v == ''
    return ''
  endif

  if getpos('$')[1] == a:line
    return ''
  endif

  let next = getline(a:line + 1)
  if next =~ '\v^-+$'
    return '-'
  elseif next =~ '\v^\=+$'
    return '='
  endif

  return ''
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
