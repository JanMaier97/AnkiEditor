from . import anki_connect as anki
import vim
from .utils import setlocal

class NoteEditor():
    def __init__(self):
        self.current_model = None
        self.current_deck = None
        self.field_names = None

        self.field_buffer_names = []
        self.tag_buffer_name = None

    def create_new_note(self, model_name):
        self.field_names = anki.get_field_names(model_name.strip('"'))

        for name in self.field_names:
            vim.command('silent keepalt split ' + name)
            self._init_window()
        vim.command('silent keepalt split Tags')
        self._init_window()

        
    def _init_window(self):
        setlocal("buftype=nofile")
        setlocal("bufhidden=hide")
        setlocal("noswapfile")
        setlocal("nobuflisted")        

    def add_note(self, deck_name):
        print("Test Test")

    def edit_note(self, nid):
        pass

    def update_note(self, nid):
        pass


