import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';

class SignUpViewModel extends ViewModel {
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

  signUp() {
    try {
      final credential = _authentication.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/loginScreen', (route) => false);
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('The password provided is too weak.')),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('The account already exists for that email.')),
        );
      }
    } catch (e) {
      return (e);
    }
  }
}
