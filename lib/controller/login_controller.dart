import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/class/crud.dart';

import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/core/constant/linkAuth.dart';
import 'package:medecin_warehouse/view/widget/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  final Crud crud = Crud();

  String? validateMobile(String mobile) {
    if (mobile.isEmpty) return "Mobile cannot be empty";
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return "Password cannot be empty";
    return null;
  }

  login(BuildContext context, String mobile, String password) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.darkerGreen,
          backgroundColor: AppColors.lightGreen,
        ),
      ),
    );
    try {
      var response = await crud.postRequest(linkLogin, {
        "mobile": mobile,
        "password": password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = jsonDecode(response.body);

        String token = responseData['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => NavBar()),
          (Route<dynamic> route) => false,
        );
      } else {
        var responseData = jsonDecode(response.body);
        var errorMessage = responseData['message'] ?? 'Login Failed';
        print(errorMessage);
      }
    } catch (e) {
      print("Login Error: $e");
    }
  }
}
