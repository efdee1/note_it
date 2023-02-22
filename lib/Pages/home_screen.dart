import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_it/Pages/note_details.dart';
import 'package:note_it/config/size_config.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/services/firestore.dart';
import 'package:note_it/viewmodel/home_viewmodel.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home_Screen";
  HomeScreen({Key? key}) : super(key: key);
  final ref = FirebaseFirestore.instance.collection('notes');
  final FireStoreService fireStoreService = FireStoreService();
  final FirebaseFirestore stream = FireStoreService().db;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MVVM<HomeViewModel>.builder(
        viewModel: locator<HomeViewModel>(),
        disposeVM: false,
        viewBuilder: (_, viewModel) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "NoteIt",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        viewModel.signOut();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white))
                ],
                backgroundColor: Colors.deepPurple.shade300,
                elevation: 0.5,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('notes')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, int index) {
                              final note = snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NoteDetails(note.id)),
                                  );
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['title']
                                                    .toString()
                                                    .toUpperCase()
                                                    .length >
                                                18
                                            ? '${snapshot.data!.docs[index]['title'].toString().toUpperCase().substring(0, 18)}...'
                                            : snapshot
                                                .data!.docs[index]['title']
                                                .toString()
                                                .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!
                                                    .docs[index]['description']
                                                    .toString()
                                                    .length >
                                                50
                                            ? '${snapshot.data!.docs[index]['description'].toString().substring(0, 50)}...'
                                            : snapshot.data!.docs[index]
                                                ['description'],
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        viewModel.deleteNote(
                                            snapshot.data!.docs[index].id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.deepPurple.shade300,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Center(child: Text('note empty'));
                      }
                    },
                  )),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.deepPurple.shade300,
                child: const Icon(Icons.note_add_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, '/addNoteScreen');
                },
              ),
            ));
  }
}
