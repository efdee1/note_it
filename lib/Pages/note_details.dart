import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_it/Pages/edit_note.dart';
import 'package:note_it/config/size_config.dart';

class NoteDetails extends StatelessWidget {
  static String routeName = "/noteDetails";
  NoteDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('notes').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        centerTitle: true,
        title: const Text('Note details'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                //add the id to the map
                data['id'] = itemId;

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditNote(data)));
              },
              icon: const Icon(Icons.edit_note_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<DocumentSnapshot>(
          future: _futureData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              //Get the data
              DocumentSnapshot documentSnapshot = snapshot.data;
              data = documentSnapshot.data() as Map;

              //display the data
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(30),
                    ),
                    Text('${data['title']}'),
                    SizedBox(
                      height: height(50),
                    ),
                    Text('${data['description']}'),
                  ],
                ),
              );
            }

            return const Center(
                child: Padding(
              padding: EdgeInsets.all(18.0),
              child: CircularProgressIndicator.adaptive(),
            ));
          },
        ),
      ),
    );
  }
}
