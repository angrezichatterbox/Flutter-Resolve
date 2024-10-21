import 'package:flutter/material.dart';
import 'package:flutter_resolve/note_controller.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteController noteController = NoteController();
  final TextEditingController noteControllerText = TextEditingController();
  int _selectedIndex = 0;

  void _addNote() {
    noteController.addNote(noteControllerText.text);
    noteControllerText.clear();
    setState(() {});
  }

  void _editNote(int index) {
    noteControllerText.text = noteController.notes[index].content;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Edit Note', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: noteControllerText,
            decoration: const InputDecoration(hintText: 'Edit your note'),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (noteControllerText.text.isNotEmpty) {
                  noteController.editNote(index, noteControllerText.text);
                  noteControllerText.clear();
                  setState(() {});
                  Navigator.pop(context);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        );
      },
    );
  }

  void _removeNote(int index) {
    noteController.removeNote(index);
    setState(() {});
  }

  void _clearNotes() {
    noteController.clearNotes();
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearNotes,
          ),
        ],
      ),
      body: _buildNotesList(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildNotesList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: noteControllerText,
                  decoration: const InputDecoration(
                    hintText: 'Enter your note here',
                    prefixIcon: Icon(Icons.note_add, color: Colors.deepPurple),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: _addNote,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: noteController.notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(noteController.notes[index].content),
                onDismissed: (direction) {
                  _removeNote(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note removed'), backgroundColor: Colors.red),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  color: Colors.grey[850],
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    title: Text(
                      noteController.notes[index].content,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Created on: ${noteController.notes[index].timestamp.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editNote(index),
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
