import 'package:get_it/get_it.dart';
import 'package:note_it/services/firestore.dart';
import 'package:note_it/viewmodel/auth_viewmodel.dart';
import 'package:note_it/viewmodel/home_viewmodel.dart';
import 'package:note_it/viewmodel/signup_viewmodel.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => FireStoreService());
}
