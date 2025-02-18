import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/services/all_service.dart';

List<Map<String, dynamic>> cartItems = [];
List<Map<String, dynamic>> favoriteItems = [];

class DetailsMedicineScreen extends StatefulWidget {
  int x;
  DetailsMedicineScreen({required this.x});

  @override
  State<DetailsMedicineScreen> createState() => _DetailsMedicineScreenState();
}

class _DetailsMedicineScreenState extends State<DetailsMedicineScreen> {
  bool isAlreadyInCart(int productId) {
    return cartItems.any((item) => item['product_id'] == productId);
  }

  bool isAlreadyInFavorites(int productId) {
    return favoriteItems.any((item) => item['product_id'] == productId);
  }

  void _addToCart(int productId) async {
    if (isAlreadyInCart(productId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orange,
          content: Text('The Product is already in the cart'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      var response = await Services().addToCart(productId: productId);
      if (response['id'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.green,
            content: Text('Product added to cart successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('The Product is already in the cart'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _addToFavorites(int productId) async {
    if (isAlreadyInFavorites(productId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('The Product is already in Favorites'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      try {
        var response =
            await Services().addProductToFavorite(productId: productId);
        if (response['id'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blueAccent,
              content: Text('The Product added to Favorites'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            favoriteItems.add(response);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('The Product is already in Favorites'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: Services().getDeatilsMedecine(x: widget.x),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  color: AppColors.primary,
                  child: Align(
                    alignment: const Alignment(0, -0.99),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 270,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white,
                                    )),
                                Text(
                                  S.of(context).DeatilsMedicin,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _addToFavorites(snapshot.data!['id']),
                                  icon: const Icon(Icons.favorite),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            (snapshot.data!['photo'] != null)
                                ? Image.network(
                                    "http://${Services().host}/${snapshot.data!['photo']}",
                                    height: 100,
                                    width: 120,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(60)),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "${snapshot.data!['Scientific_Name']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${snapshot.data!['description']}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${S.of(context).Expires}: ${snapshot.data!['Expiration_Date']}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 112, 106, 106)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 600),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 600),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${S.of(context).Price}: ${snapshot.data!['Price']} SYP",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () => _addToCart(snapshot.data!['id']),
                          icon: const Icon(Icons.shopping_cart_outlined),
                          label: Text(
                            S.of(context).ADDTOCART,
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.darkerGreen,
                            minimumSize: const Size(270, 50),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }
}
