import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_it/Pages/home_screen.dart';
import 'package:note_it/Pages/login_screen.dart';
import 'package:note_it/locator.dart';
import 'package:note_it/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await setupLocator();
    runApp(const MyApp());
  } catch (error) {
    (error);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteIt',
      theme: ThemeData(),
      routes: routes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const CircularProgressIndicator.adaptive();
                  }
                  if (snapshot.hasData) {
                    return HomeScreen();
                  } else {
                    return LoginScreen();
                  }
                }));
      },
    );
  }
}
