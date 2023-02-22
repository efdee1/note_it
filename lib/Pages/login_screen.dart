import 'package:flutter/material.dart';
import 'package:note_it/Pages/sign_up_screen.dart';
import 'package:note_it/config/size_config.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/viewmodel/auth_viewmodel.dart';
import 'package:note_it/widgets/login_button.dart';
import 'package:pmvvm/pmvvm.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/loginScreen";
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MVVM<LoginViewModel>.builder(
        viewModel: locator<LoginViewModel>(),
        disposeVM: false,
        viewBuilder: (_, viewModel) => Scaffold(
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Center(
                        child: Container(
                            width: 100.0,
                            height: 140.0,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple[300],
                              shape: BoxShape.circle,
                              // border: Border.all(width: 2)
                            ),
                            child: const Center(
                                child: Text('Ni',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 70)))),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: viewModel.emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "email cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: 'Email address',
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: viewModel.passwordController,
                              obscureText: viewModel.isPasswordHidden,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                } else if (value.length < 6) {
                                  return "Password is too short";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                icon: const Icon(Icons.key),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    viewModel.togglePassword();
                                  },
                                  child: Icon(
                                    viewModel.isPasswordHidden
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            MainButton(
                                text: 'LOG IN',
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    viewModel.signIn();
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                    color: Colors.deepPurple.shade300),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
