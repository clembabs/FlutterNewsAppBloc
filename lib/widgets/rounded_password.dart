import 'package:flutter/material.dart';
import 'package:newsapp_bloc/widgets/text_field.dart';

import 'constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  const RoundedPasswordField({
    Key key,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        obscureText: hidePass,
        validator: widget.validator,
        autocorrect: false,
        autovalidate: true,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
            ),
            color: kPrimaryColor,
            onPressed: () {
              setState(() {
                hidePass = !hidePass;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
