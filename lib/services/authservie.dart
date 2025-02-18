import 'dart:convert';

import 'package:http/http.dart' as http;

class Authservice {
  String host = '192.168.43.129:8000';
  static String? token;

  Future<dynamic> login({
    required String phoneNumber,
    required String password,
  }) async {
    http.Response response = await http.post(
      Uri.parse("http://$host/api/login"),
      body: {
        "mobile": phoneNumber,
        "password": password,
      },
      headers: {
        "Accept": "application/json",
      },
    );

    dynamic responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      token = responseBody['token'];
      return responseBody;
    } else {
      throw Exception(responseBody["message"]);
    }
  }

  Future<dynamic> Signup(
      {required String phoneNumber,
      required String password,
      required String name,
      required String email,
      required String confirmpassword}) async {
    http.Response response = await http.post(
      Uri.parse("http://$host/api/register"),
      body: {
        "name": name,
        "mobile": phoneNumber,
        "email": email,
        "password": password,
        "password_confirmation": confirmpassword
      },
      headers: {
        "Accept": "application/json",
      },
    );
    dynamic responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      token = responseBody['token'];
      return responseBody;
    } else {
      throw Exception(responseBody["message"]);
    }
  }
}

