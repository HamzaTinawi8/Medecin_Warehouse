import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:medecin_warehouse/controller/signup_controller.dart';
import 'package:medecin_warehouse/view/widget/text_filled_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final SignUpController _signUpController = SignUpController();

  String? nameError;
  String? mobileError;
  String? emailError;
  String? passwordError;
  String? passwordConfirmationError;

  void _onSignUpPressed() async {
    setState(() {
      nameError = _signUpController.validateName(nameController.text);
      mobileError = _signUpController.validateMobile(mobileController.text);
      emailError = _signUpController.validateEmail(emailController.text);
      passwordError =
          _signUpController.validatePassword(passwordController.text);
      passwordConfirmationError =
          _signUpController.validatePasswordConfirmation(
              passwordController.text, passwordConfirmationController.text);
    });

    if (nameError == null &&
        mobileError == null &&
        emailError == null &&
        passwordError == null &&
        passwordConfirmationError == null) {
      await _signUpController.signUp(
        context,
        nameController.text,
        mobileController.text,
        emailController.text,
        passwordController.text,
        passwordConfirmationController.text,
      );
    } else {
    }
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
              'Sign Up',
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
                    controller: nameController,
                    labelText: 'Name',
                    errorText: nameError,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: mobileController,
                    labelText: 'PhoneNumber',
                    keyboardType: TextInputType.phone,
                    errorText: mobileError,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: emailController,
                    labelText: 'E-mail address',
                    keyboardType: TextInputType.emailAddress,
                    errorText: emailError,
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    errorText: passwordError,
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    controller: passwordConfirmationController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    errorText: passwordConfirmationError,
                  ),
                  SizedBox(height: 50.0),
                  ElevatedButton(
                    child: Text('Sign Up'),
                    onPressed: _onSignUpPressed,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                    ),
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
