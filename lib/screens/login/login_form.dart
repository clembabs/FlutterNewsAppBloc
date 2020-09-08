import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsapp_bloc/bloc/authentication/bloc.dart';
import 'package:newsapp_bloc/bloc/login/bloc.dart';
import 'package:newsapp_bloc/repository/UserRepository.dart';
import 'package:newsapp_bloc/screens/signup/signup.dart';
import 'package:newsapp_bloc/widgets/already_have_an_account.dart';
import 'package:newsapp_bloc/widgets/background.dart';
import 'package:newsapp_bloc/widgets/rounded_button.dart';
import 'package:newsapp_bloc/widgets/rounded_input_field.dart';
import 'package:newsapp_bloc/widgets/rounded_password.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      emailTextEditingController.text.isNotEmpty &&
      passwordTextEditingController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    emailTextEditingController.addListener(_onEmailChanged);
    passwordTextEditingController.addListener(_onPasswordChanged);

    super.initState();
  }
//Email changed
  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: emailTextEditingController.text),
    );
  }
//password changed
  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: passwordTextEditingController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text),
    );
  }

  @override
  void dispose() {
    passwordTextEditingController.dispose();
    emailTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Login Failed"),
                    Icon(Icons.error),
                  ],
                ),
              ),
            );
        }

        if (state.isSubmitting) {
          print("isSubmitting");
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(" Logging In..."),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
              ),
            );
        }

        if (state.isSuccess) {
          print("Success");
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
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
                    text: "LOG IN",
                    textColor: Colors.white,
                    color: isLoginButtonEnabled(state)
                        ? Colors.purple
                        : Colors.purpleAccent,
                    press:
                        isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: true,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUp(
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
}
