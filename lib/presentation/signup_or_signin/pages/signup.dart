// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecase/auth/signup.dart';
import 'package:spotify/presentation/root/pages/root.dart';
import 'package:spotify/presentation/signup_or_signin/pages/signin.dart';
import 'package:spotify/service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
          child: KeyboardAvoider(
            autoScroll: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _registerText(),
                SizedBox(height: 50),
                _fullNameField(context),
                SizedBox(height: 20),
                _emailField(context),
                SizedBox(height: 20),
                _passwordField(context),
                SizedBox(height: 20),
                BasicAppButton(
                    onPressed: () async {
                      var result = await sl<SignupUseCase>().call(
                          params: CreateUserReq(
                              fullName: _fullName.text.toString(),
                              email: _email.text.toString(),
                              password: _password.text.toString()));
                      result.fold((l) {
                        var snackBar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }, (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RootPage()),
                            (route) => false);
                      });
                    },
                    title: "Create Account")
              ],
            ),
          ),
        ));
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: "Enter Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
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
              "Do you have an account?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninPage(),
                    ));
              },
              child: Text(
                "Sign in",
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
