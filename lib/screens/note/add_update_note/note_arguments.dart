import 'package:notesapp/model/note.dart';

class NoteArguments {
  final Note? note;
  final String? userId;

  NoteArguments({
    this.note,
    this.userId,
  });
}
