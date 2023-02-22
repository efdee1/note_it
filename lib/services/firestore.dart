import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_it/model/note_model.dart';

class FireStoreService {
  static final FireStoreService _fireStoreService =
      FireStoreService._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final ref = FirebaseFirestore.instance.collection('notes');
  FireStoreService._internal();

  factory FireStoreService() {
    return _fireStoreService;
  }

  Stream<List<Note>> readNotes() {
    return db.collection('notes').snapshots().map((snapshot) => snapshot.docs
        .map(
          (doc) => Note.fromMap(doc.data as Map<String, dynamic>, doc.id),
        )
        .toList());
  }

  Future<void> createNote(Note note) {
    return db.collection('notes').add(note.toMap());
  }

  Future<void> deleteNote(String id) {
    return db.collection('notes').doc(id).delete();
  }

  Future<void> updateNote(Note note) {
    return db.collection('notes').doc(note.id).update(note.toMap());
  }
}
