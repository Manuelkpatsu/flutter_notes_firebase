class NoteArguments {
  final String title;
  final String description;
  final String? date;
  final int priority;
  final int color;

  NoteArguments({
    required this.title,
    required this.description,
    this.date,
    required this.priority,
    required this.color,
  });
}
