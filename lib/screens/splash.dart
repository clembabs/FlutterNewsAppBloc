import 'package:flutter/material.dart';
import 'package:newsapp_bloc/widgets/constants.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        width: size.width,
        child: Center(
          child: Text(
            "NewsApp",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
