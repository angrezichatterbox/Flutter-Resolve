class Note {
  String content;
  DateTime timestamp;
  bool isImportant;

  Note({
    required this.content,
    required this.timestamp,
    this.isImportant = false,
  });
}
