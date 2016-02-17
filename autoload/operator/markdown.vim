let s:save_cpo = &cpo
set cpo&vim

let g:operator#markdown#force_header_underline = get(g:, 'operator#markdown#force_header_underline', 0)

function! operator#markdown#right_header(_motion_wise) abort
  call s:loop(function('s:right'))
endfunction

function! operator#markdown#left_header(_motion_wise) abort
  call s:loop(function('s:left'))
endfunction


function! s:loop(f) abort
  let start_l = getpos("'[")[1]
  let end_l   = getpos("']")[1]

  let line = start_l

  while line <= end_l
    let t = s:header_type(line)

    if t != ''
      let end_l += a:f(t, line)
    endif

    let line += 1
  endwhile
endfunction


function! s:right(t, line) abort
  let v = getline(a:line)
  if a:t == '#'
    if len(matchlist(v, '\v^(#+)(.+)$')[1]) == 6
      return 0
    endif
    call setline(a:line, '#' . v)
  elseif a:t == '='
    let x = getline(a:line+1)
    call setline(a:line+1, substitute(x, '.', '-', 'g'))
  elseif a:t == '-'
    call setline(a:line, '### ' . v)
    execute string(a:line+1) . 'delete'
    normal! k
    return -1
  endif
  return 0
endfunction

function! s:left(t, line) abort
  let v = getline(a:line)

  if a:t == '#'
    let m = matchlist(v, '\v^(#+)(.+)$')
    let n = len(m[1])
    if n == 1
      return 0
    endif

    if g:operator#markdown#force_header_underline && n <= 3
      call setline(a:line, m[2])
      if n == 2
        call append(a:line, substitute(m[2], '.', '=', 'g'))
      elseif n == 3
        call append(a:line, substitute(m[2], '.', '-', 'g'))
      endif

      return 0
    endif

    call setline(a:line, v[1:])

  elseif a:t == '='
    " なにもしない
  elseif a:t == '-'
    let x = getline(a:line+1)
    call setline(a:line+1, substitute(x, '.', '=', 'g'))
  endif

  return 0
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
