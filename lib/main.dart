import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/home.dart';

import 'bloc/authentication/bloc.dart';
import 'bloc/blocDelegate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepository _userRepository = UserRepository();

  Bloc.observer = SimpleBlocObserver();

  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: Home(userRepository: _userRepository)));
}
