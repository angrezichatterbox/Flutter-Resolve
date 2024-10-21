import 'package:flutter/material.dart';
import 'package:flutter_resolve/notes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taking App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          elevation: 8,
          color: Colors.grey[850],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
        
      ),
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final List<Note> notes = [];
  final TextEditingController noteController = TextEditingController();
  int _selectedIndex = 0;

  void _addNote() {
    if (noteController.text.isNotEmpty) {
      setState(() {
        notes.add(Note(
          content: noteController.text,
          timestamp: DateTime.now(),
        ));
        noteController.clear();
      });
    }
  }

  void _editNote(int index) {
    noteController.text = notes[index].content;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Edit Note', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: noteController,
            decoration: const InputDecoration(hintText: 'Edit your note'),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (noteController.text.isNotEmpty) {
                  setState(() {
                    notes[index].content = noteController.text;
                    notes[index].timestamp = DateTime.now();
                    noteController.clear();
                  });
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
    setState(() {
      notes.removeAt(index);
    });
  }

  void _clearNotes() {
    setState(() {
      notes.clear();
    });
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
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: _clearNotes,
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildNotesList() : _buildSettingsOrAbout(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
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
                  controller: noteController,
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
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(notes[index].content),
                onDismissed: (direction) {
                  _removeNote(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Note removed'),
                      backgroundColor: Colors.red,
                    ),
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
                  child: ListTile(
                    title: Text(
                      notes[index].content,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Created on: ${notes[index].timestamp.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            notes[index].isImportant
                                ? Icons.star
                                : Icons.star_border,
                            color: notes[index].isImportant
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              notes[index].isImportant = !notes[index].isImportant;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editNote(index),
                          color: Colors.deepPurple,
                        ),
                      ],
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

  Widget _buildSettingsOrAbout() {
    if (_selectedIndex == 1) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'About\nThis is a simple note-taking app built with Flutter.\nVersion 1.0',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
  }
}
