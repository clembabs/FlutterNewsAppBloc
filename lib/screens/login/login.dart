import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/bloc/login/bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/login/login_form.dart';

class Login extends StatelessWidget {
  final UserRepository _userRepository;

  Login({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            userRepository: _userRepository,
          ),
          child: LoginForm(
            userRepository: _userRepository,
          ),
        ),
      ),
    );
  }
}
