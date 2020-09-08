
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/bloc/signup/bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/signup/signup_form.dart';
import 'package:newsapp_bloc/widgets/constants.dart';

class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  SignUp({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
            userRepository: _userRepository,
          ),
          child: SignUpForm(
            userRepository: _userRepository,
          ),
        ),
      ),
    );
  }
}