import 'package:flutter/material.dart';
import 'package:note_it/Pages/add_note.dart';
import 'package:note_it/Pages/home_screen.dart';
import 'package:note_it/Pages/login_screen.dart';
import 'package:note_it/Pages/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  AddNoteScreen.routeName: (context) => const AddNoteScreen(),
};
