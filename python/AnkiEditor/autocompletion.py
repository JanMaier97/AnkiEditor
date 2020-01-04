import AnkiEditor.anki_connect as anki

def autocomplete_model_name(arg_lead, cmd_line, curser_pos):
    return _surround_with_quotes(sorted(anki.get_model_names()))

def autocomplete_deck_name(arg_lead, cmd_line, curser_pos):
    return _surround_with_quotes(sorted(anki.get_model_names()))

def _surround_with_quotes(string_list):
    return [ '"'+item+'"' if ' ' in item else item for item in string_list]

