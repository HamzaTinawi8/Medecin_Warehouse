import 'dart:convert';
import 'package:http/http.dart' as http;

class Crud {
  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<http.Response> postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      return response; // Return the entire response object
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to connect to the server.');
    }
  }
}
