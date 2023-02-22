import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';

class LoginViewModel extends ViewModel {
  final _authentication = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  void togglePassword() {
    if (isPasswordHidden == true) {
      isPasswordHidden = false;
    } else {
      isPasswordHidden = true;
    }
    notifyListeners();
  }

  signIn() {
    try {
      final credential = _authentication.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (credential != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home_Screen', (route) => false);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Wrong password provided for that user.')),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User already exist.')),
        );
      }
    }
  }
}
