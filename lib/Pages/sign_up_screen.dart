import 'package:flutter/material.dart';
import 'package:note_it/config/size_config.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/viewmodel/signup_viewmodel.dart';
import 'package:note_it/widgets/login_button.dart';
import 'package:pmvvm/mvvm_builder.widget.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signupScreen";
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MVVM<SignUpViewModel>.builder(
        viewModel: locator<SignUpViewModel>(),
        disposeVM: false,
        viewBuilder: (_, viewModel) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_sharp,
                        color: Colors.black)),
                title: const Center(
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0.5,
              ),
              body: Padding(
                padding: const EdgeInsets.all(30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const Text('Create Your Account',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w700)),
                      const Text('please enter info to create account',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: height(150),
                      ),
                      Center(
                        child: Form(
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
                                  text: 'SIGN UP',
                                  press: () {
                                    if (_formKey.currentState!.validate()) {
                                      viewModel.signUp();
                                    }
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
