import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_bloc/bloc/authentication/bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/login/login.dart';
import 'package:newsapp_bloc/screens/news/news_page.dart';
import 'package:newsapp_bloc/screens/signup/signup.dart';
import 'package:newsapp_bloc/screens/splash.dart';
import 'package:newsapp_bloc/widgets/constants.dart';

class Home extends StatelessWidget {
  final UserRepository _userRepository;

  Home({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: kPrimaryColor,
          accentColor: Color(0XFFFEF9EB),
          scaffoldBackgroundColor: Colors.white),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }
          if (state is Unauthenticated) {
            return Login(
              userRepository: _userRepository,
            );
          }
          if (state is Authenticated) {
            return NewsPage();
          } else
            return Container();
        },
      ),
    );
  }
}
