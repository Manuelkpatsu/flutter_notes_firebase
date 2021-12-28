import 'package:notesapp/screens/note/add_update_note/note_arguments.dart';

abstract class ViewNoteEvent {}

class DeleteNoteEvent extends ViewNoteEvent {}

class EditNoteEvent extends ViewNoteEvent {
  final NoteArguments arguments;

  EditNoteEvent(this.arguments);
}
