import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp/model/note.dart';

class NoteRepository {
  static const noteCollection = 'notes';

  final FirebaseFirestore _firestore;

  NoteRepository(this._firestore);

  Future<List<Note>> getNoteList(String currentUserId) {
    return _firestore
        .collection(noteCollection)
        .orderBy('createdAt', descending: true)
        .where('userId', isEqualTo: currentUserId)
        .get()
        .then((snap) => snap.docs
            .map((result) => Note.fromSnapshot(result.id, result.data()))
            .toList());
  }

  Future<Note> getNote(String noteId) {
    return _firestore
        .collection(noteCollection)
        .doc(noteId)
        .get()
        .then((result) => Note.fromSnapshot(result.id, result.data()!));
  }

  Future<void> deleteNote(String noteId) {
    return _firestore.collection(noteCollection).doc(noteId).delete();
  }

  Future<void> updateNote(String noteId, Note note) {
    return _firestore.collection(noteCollection).doc(noteId).update(note.toJson());
  }

  Future<void> addNote(Note note) {
    return _firestore.collection(noteCollection).add(note.toJson());
  }
}
