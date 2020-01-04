if !has('python3')
    echo "Error: Requried vim compiled with +python3"
    finish
endif

if exists('g:anki_editor_loaded')
  finish
endif

let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
from AnkiEditor.note_editor import NoteEditor
from AnkiEditor.autocompletion import autocomplete_model_name, autocomplete_deck_name

note_editor = NoteEditor()
EOF

let g:anki_editor_loaded = 1

function! AnkiModelNameCompletion(args, line, pos)
    python3 vim.command("return {0}".format(autocomplete_model_name(vim.eval("a:args"), vim.eval("a:line"), vim.eval("a:pos"))))
endfunction

function! AnkiNewNote(model_name)
    " python3 print(vim.eval("a:model_name"))
    python3 note_editor.create_new_note(vim.eval("a:model_name"))
endfunction

command! -nargs=1 -complete=customlist,AnkiModelNameCompletion AnkiNewNote call AnkiNewNote(<f-args>)


function! AnkiDeckNameCompletion(args, line, pos)
    python3 vim.command("return {0}".format(autocomplete_deck_name(vim.eval("a:args"), vim.eval("a:line"), vim.eval("a:pos"))))
endfunction

function! AnkiAddNote(deck_name)
    python3 note_editor.add_note(vim.eval("a:deck_name")) 
endfunction

command! -nargs=1 -complete=customlist,AnkiDeckNameCompletion AnkiAddNote call AnkiAddNote(<f-args>)


