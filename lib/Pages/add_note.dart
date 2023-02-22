import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_it/config/size_config.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/model/note_model.dart';
import 'package:note_it/services/firestore.dart';
import 'package:note_it/viewmodel/home_viewmodel.dart';
import 'package:note_it/widgets/login_button.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';

class AddNoteScreen extends StatefulWidget {
  static String routeName = "/addNoteScreen";
  final DocumentSnapshot? make;
  final Note? take;
  const AddNoteScreen({Key? key, this.make, this.take}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MVVM<HomeViewModel>.builder(
        viewModel: locator<HomeViewModel>(),
        disposeVM: false,
        viewBuilder: (_, viewModel) => Scaffold(
            appBar: AppBar(
              title: const Center(
                  child: Text(
                "Add Note",
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
                                controller: titleController,
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
                                controller: descriptionController,
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
                                  text: ("SAVE"),
                                  press: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        await FireStoreService().createNote(
                                            Note(
                                                titleController.text,
                                                descriptionController.text,
                                                idController.text));
                                        Navigator.pop(context);
                                      } catch (e) {
                                        throw Exception(e);
                                      }
                                    }
                                  }),
                              SizedBox(
                                height: height(10),
                              ),
                            ]))))));
  }
}
