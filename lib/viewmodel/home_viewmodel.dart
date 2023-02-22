import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/services/firestore.dart';
import 'package:pmvvm/view_model.dart';

class HomeViewModel extends ViewModel {
  final storeService = locator<FireStoreService>();
  FireStoreService fireStoreService = FireStoreService();
  CollectionReference users = FirebaseFirestore.instance.collection('notes');

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController idController = TextEditingController();

  signOut() {
    FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushNamedAndRemoveUntil(
            context, '/loginScreen', (route) => false));
  }

  deleteNote(String id) async {
    try {
      await FireStoreService().deleteNote(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
