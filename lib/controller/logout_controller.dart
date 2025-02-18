import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/view/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController {
  Future<void> logout(BuildContext context) async {
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');
       String host = "10.0.2.2:8000";

      if (token != null) {
        var response = await http.post(
          Uri.parse("http://$host/api/logout"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Logout successful');
        } else {
          print('Error during logout: ${response.statusCode}');
        }
      }

      await prefs.clear();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Logout Error: $e");
      Navigator.of(context).pop();
    }
  }
}