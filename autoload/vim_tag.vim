let s:save_cpo = &cpo
set cpo&vim

function! s:mk_tags_regexp(tags)
    let tags_regexp = ''
    for tag in a:tags
        let tags_regexp = tags_regexp . '\|' . tag
    endfor
    let tags_regexp = substitute(tags_regexp, '^\\|', '', '')
    return tags_regexp
endfunction

function! s:attach_tag(line, tag)
    if a:line !~ ' *[-\*] .*'
        return line
    endif
    return substitute(a:line, '^\( *[-\*] \)', '\1[' . a:tag . '] ', '')
endfunction

" -- タグを追加したい場合、この下を修正する。 --

let s:tags = ['主張', '所感', '理由', '証拠', '例', '推測', '事実', '引用', '原因', 'done', '!']

function! vim_tag#claim(line)
    call setline('.', s:attach_tag(a:line, '主張'))
endfunction

function! vim_tag#comment(line)
    call setline('.', s:attach_tag(a:line, '所感'))
endfunction

function! vim_tag#reason(line)
    call setline('.', s:attach_tag(a:line, '理由'))
endfunction

function! vim_tag#evidence(line)
    call setline('.', s:attach_tag(a:line, '証拠'))
endfunction

function! vim_tag#example(line)
    call setline('.', s:attach_tag(a:line, '例'))
endfunction

function! vim_tag#conjecture(line)
    call setline('.', s:attach_tag(a:line, '推測'))
endfunction

function! vim_tag#fact(line)
    call setline('.', s:attach_tag(a:line, '事実'))
endfunction

function! vim_tag#quote(line)
    call setline('.', s:attach_tag(a:line, '引用'))
endfunction

function! vim_tag#cause(line)
    call setline('.', s:attach_tag(a:line, '原因'))
endfunction

function! vim_tag#todo(line)
    call setline('.', s:attach_tag(a:line, '!'))
endfunction

function! vim_tag#done(line)
    call setline('.', s:attach_tag(a:line, 'done'))
endfunction

" -- タグを追加したい場合、この上を修正する。 --

function! s:remove_tags(line)
    if a:line !~ ' *[-\*] \[\(' . s:mk_tags_regexp(s:tags) . '\)\].*'
        return a:line
    else
        return s:remove_tags(substitute(a:line, '\[[^\]]*\] ', '', ''))
    endif
endfunction

function! vim_tag#remove_tags(line)
    call setline('.', s:remove_tags(a:line))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
