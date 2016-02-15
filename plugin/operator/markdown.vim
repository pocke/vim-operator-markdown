let s:save_cpo = &cpo
set cpo&vim


call operator#user#define('markdown-right', 'operator#markdown#right_header')
call operator#user#define('markdown-left',  'operator#markdown#left_header')


let &cpo = s:save_cpo
unlet s:save_cpo
