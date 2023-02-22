import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_it/config/size_config.dart';
import 'package:note_it/widgets/login_button.dart';

class EditNote extends StatefulWidget {
  static String routeName = "/editNote";
  EditNote(this._note, {Key? key}) {
    _controllerTitle = TextEditingController(text: _note['title']);
    _controllerDescription = TextEditingController(text: _note['description']);

    _reference =
        FirebaseFirestore.instance.collection('notes').doc(_note['id']);
  }

  final Map _note;
  late DocumentReference _reference;

  late TextEditingController _controllerTitle;
  late TextEditingController _controllerDescription;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Edit Note",
            style: TextStyle(color: Colors.black),
          )),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height(31),
                          ),
                          TextFormField(
                            controller: widget._controllerTitle,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter a title";
                              } else if (value.length < 4) {
                                return "Title is too short";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Title",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurple.shade300),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height(26),
                          ),
                          TextFormField(
                            controller: widget._controllerDescription,
                            maxLines: 17,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return " cannot be empty";
                              } else if (value.length < 6) {
                                return "Too short";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurple.shade300),
                              ),
                              hintText: "Note",
                              hintStyle: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: const OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                          SizedBox(
                            height: height(47),
                          ),
                          MainButton(
                              text: ("SAVE EDIT"),
                              press: () async {
                                if (_formKey.currentState!.validate()) {
                                  String title = widget._controllerTitle.text;
                                  String description =
                                      widget._controllerDescription.text;

                                  //Create the Map of data
                                  Map<String, String> dataToUpdate = {
                                    'title': title,
                                    'description': description
                                  };

                                  //Call update()
                                  widget._reference.update(dataToUpdate);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/home_Screen', (route) => false);
                                }
                              }),
                        ])))));
  }
}
