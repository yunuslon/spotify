// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/signup_or_signin/pages/signup.dart';

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppbar(
          title: SvgPicture.asset(
            AppVectors.logo,
            width: 40,
            height: 40,
          ),
        ),
        bottomNavigationBar: _signText(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              SizedBox(height: 50),
              _emailField(context),
              SizedBox(height: 20),
              _passwordField(context),
              SizedBox(height: 20),
              BasicAppButton(onPressed: () {}, title: "Sign in")
            ],
          ),
        ));
  }

  Widget _registerText() {
    return const Text(
      "Sign in",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Enter Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Not A Member?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => SignupPage()));
              },
              child: Text(
                "Register Now",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ));
  }
}
