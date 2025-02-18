import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/class/crud.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/core/constant/linkAuth.dart';
import 'package:medecin_warehouse/view/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController {
  final Crud crud = Crud();

  String? validateName(String name) {
    if (name.isEmpty) return "Name cannot be empty";
    return null;
  }

  String? validateMobile(String mobile) {
    if (mobile.isEmpty) return "Mobile number cannot be empty";
    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) return "Email cannot be empty";
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Password cannot be empty";
    return null;
  }

  String? validatePasswordConfirmation(
      String password, String passwordConfirmation) {
    if (password != passwordConfirmation) return "Passwords do not match";
    return null;
  }

  Future<void> signUp(BuildContext context, String name, String mobile,
      String email, String password, String passwordConfirmation) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: AppColors.darkerGreen,
        backgroundColor: AppColors.lightGreen,
      )),
    );

    try {
      var response = await crud.postRequest(linkSignUp, {
        "name": name,
        "mobile": mobile,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          var responseData = jsonDecode(response.body);
          print("API Response: $responseData");
          String token = responseData['token'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('authToken', token);
          await prefs.setString('name', name);
          print("Saved username: $name");

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          print('Response is not JSON. Actual response: ${response.body}');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print("SignUp Error: $e");
    }
  }
}
