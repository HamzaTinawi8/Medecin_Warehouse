import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medecin_warehouse/data/model/category_search.dart';
import 'package:medecin_warehouse/data/model/medicine_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  Future<String> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken') ?? '';
  }

  String host = "10.0.2.2:8000";

  Future<List> getcompany() async {
    String token = await _getToken();

    var url = "http://$host/api/company";
    http.Response response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer $token"});
    List responseBody = jsonDecode(response.body);

    return responseBody;
  }

  Future<List<MedicineSearch>> searchMedicine({required String query}) async {
    String token = await _getToken();
    var url = "http://$host/api/Product/search/$query";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Connection": "Keep-Alive",
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
    print(response.body);
    List responseBody = jsonDecode(response.body);
    List<MedicineSearch> medicines = [];
    for (int i = 0; i < responseBody.length; i++) {
      medicines.add(MedicineSearch.fromJson(responseBody[i]));
    }
    return medicines;
  }

  Future<List<CategorySearch>> searchbyCategory({required String query}) async {
    String token = await _getToken();
    var url = "http://$host/api//Product/search1/$query";
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Connection": "Keep-Alive",
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
    List responseBody = jsonDecode(response.body);
    print(responseBody);
    List<CategorySearch> category = [];
    for (int i = 0; i < responseBody.length; i++) {
      category.add(CategorySearch.fromJson(responseBody[i]));
    }
    return category;
  }

  Future<List> getcategories({required x}) async {
    String token = await _getToken();

    var url = "http://$host/api/company/$x";
    http.Response response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"});
    List responseBody = jsonDecode(response.body);
    print(responseBody);
    return responseBody;
  }

  Future<List> getMedecines({required x}) async {
    String token = await _getToken();

    var url = "http://$host/api/Products/${x}";
    http.Response response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"});
    List responseBody = jsonDecode(response.body);
    return responseBody;
  }

  Future<Map<String, dynamic>> getDeatilsMedecine({required int x}) async {
    String token = await _getToken();

    var url = "http://$host/api/Product/${x}";
    http.Response response = await http
        .get(Uri.parse(url), headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"});
    dynamic responseBody = jsonDecode(response.body);
    return responseBody;
  }

  Future<Map<String, dynamic>> addToCart({required int productId}) async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/addTocart/$productId");
    http.Response response = await http.post(
      url,
      headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return jsonResponse;
      } else if (jsonResponse is List) {
        return jsonResponse[0];
      } else {
        throw Exception('Unexpected response format.');
      }
    } else {
      throw Exception(
          'Failed to add to cart. Status code: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> showCart() async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/showcart");
    http.Response response = await http.get(
      url,
      headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception(
          'Failed to retrieve cart. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> deleteProductFromCart(int productId) async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/deletecart/$productId");
    http.Response response = await http.delete(
      url,
      headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to delete from cart. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> addProductToFavorite(
      {required int productId}) async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/favourite/$productId");
    http.Response response = await http.post(
      url,
      headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic>) {
        return jsonResponse;
      } else if (jsonResponse is List) {
        return jsonResponse[0];
      } else {
        throw Exception('Unexpected response format.');
      }
    } else {
      throw Exception(
          'Failed to add to cart. Status code: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> showFavorite() async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/favourites");
    http.Response response = await http.get(
      url,
      headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception(
          'Failed to retrieve cart. Status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> createOrder(
      double finalPrice, List<Map<String, dynamic>> quantityPrice) async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/Order");
    var body = jsonEncode({
      'Final_Price': finalPrice,
      'QuantityPrice': quantityPrice,
    });
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Server response: ${response.body}');
      throw Exception(
          'Failed to create the order. Status code: ${response.statusCode}');
    }
  }

  Future<List> getUserOrders() async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/order");
    http.Response response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('The Orders ')) {
        return data['The Orders '];
      } else {
        throw Exception(
            'The expected orders key was not found in the response.');
      }
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  }

  Future<List> getUserOrdersDetails(int orderId) async {
    String token = await _getToken();
    var url = Uri.parse("http://$host/api/detailsorder/$orderId");
    http.Response response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('The User')) {
        return data['The User'];
      } else {
        throw Exception(
            'The expected "The User" key was not found in the response.');
      }
    } else {
      throw Exception(
          'Server responded with status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> deletdProductFromFavourite(int ProductId) async {
    String token = await _getToken();
    var url =
        Uri.parse("http://$host/api/deleteProductFromFavourite/$ProductId");
    http.Response response =
        await http.delete(url, headers: {"Authorization": "Bearer 1|rGyubHvlWog0caYs0SxqzkVOSwDakqJSIs6rCvWX92f62800"});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Faild to delete from favourite. Status code:${response.statusCode}');
    }
  }
}
