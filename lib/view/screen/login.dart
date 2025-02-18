import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medecin_warehouse/controller/login_controller.dart';
import 'package:medecin_warehouse/view/widget/text_filled_widget.dart';

import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

  String? mobileError;
  String? passwordError;

  void _onLoginPressed() async {
    setState(() {
      mobileError = _loginController.validateMobile(mobileController.text);
      passwordError =
          _loginController.validatePassword(passwordController.text);
    });

    if (mobileError == null && passwordError == null) {
      await _loginController.login(
        context,
        mobileController.text,
        passwordController.text,
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(flip: true),
              child: Container(
                height: 170,
                color: Colors.green,
              ),
            ),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: mobileController,
                    labelText: 'PhoneNumber',
                    keyboardType: TextInputType.phone,
                    errorText: mobileError,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    errorText: passwordError,
                  ),
                  SizedBox(height: 50.0),
                  ElevatedButton(
                    child: Text('Login'),
                    onPressed: _onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? "),
                      TextButton(
                        child: Text('Sign up',
                            style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
