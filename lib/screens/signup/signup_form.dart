import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:newsapp_bloc/bloc/authentication/bloc.dart';
import 'package:newsapp_bloc/bloc/signup/bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/login/login.dart';
import 'package:newsapp_bloc/widgets/already_have_an_account.dart';
import 'package:newsapp_bloc/widgets/background.dart';
import 'package:newsapp_bloc/widgets/rounded_button.dart';
import 'package:newsapp_bloc/widgets/rounded_input_field.dart';
import 'package:newsapp_bloc/widgets/rounded_password.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository _userRepository;

  SignUpForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      emailTextEditingController.text.isNotEmpty &&
      passwordTextEditingController.text.isNotEmpty;

  bool isSignUpButtonEnabled(SignUpState state) {
    // return isPopulated && !state.isSubmitting;
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  SignUpBloc _signUpBloc;

  @override
  void initState() {
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

    emailTextEditingController.addListener(_onEmailChanged);
    passwordTextEditingController.addListener(_onPasswordChanged);

    super.initState();
  }

  void _onFormSubmitted() {
    _signUpBloc.add(
      SignUpWithCredentialsPressed(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (BuildContext context, SignUpState state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Sign Up Failed"),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Signing up..."),
                    CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),

                  //rounded inputfield widget
                  RoundedInputField(
                    controller: emailTextEditingController,
                    hintText: "Email",
                    validator: (_) {
                      return !state.isEmailValid ? "Invalid Email" : null;
                    },
                  ),

                  //rounded passwordfield widget
                  RoundedPasswordField(
                    controller: passwordTextEditingController,
                    validator: (_) {
                      return !state.isPasswordValid ? "Invalid Password" : null;
                    },
                  ),
                  
                  //rounded button widget
                  RoundedButton(
                    text: "SIGNUP",
                    textColor: Colors.white,
                    color: isSignUpButtonEnabled(state)
                        ? Colors.purple
                        : Colors.purpleAccent,
                    press:
                        isSignUpButtonEnabled(state) ? _onFormSubmitted : null,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Login(
                              userRepository: _userRepository,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      EmailChanged(email: emailTextEditingController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      PasswordChanged(password: passwordTextEditingController.text),
    );
  }

  // @override
  // void dispose() {
  //   passwordTextEditingController.dispose();
  //   emailTextEditingController.dispose();

  //   super.dispose();
  // }
}
