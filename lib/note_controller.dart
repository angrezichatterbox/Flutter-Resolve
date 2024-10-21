import 'note.dart';

class NoteController {
  final List<Note> notes = [];

  void addNote(String content) {
    if (content.isNotEmpty) {
      notes.add(Note(
        content: content,
        timestamp: DateTime.now(),
      ));
    }
  }

  void editNote(int index, String content) {
    if (index >= 0 && index < notes.length) {
      notes[index].content = content;
      notes[index].timestamp = DateTime.now();
    }
  }

  void removeNote(int index) {
    if (index >= 0 && index < notes.length) {
      notes.removeAt(index);
    }
  }

  void clearNotes() {
    notes.clear();
  }
}
