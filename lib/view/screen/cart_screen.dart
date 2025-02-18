import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/widget/cart_widget.dart';
import 'package:medecin_warehouse/view/widget/home/top_container.dart';

import '../../generated/l10n.dart';

class Cartpage extends StatefulWidget {
  Cartpage({Key? key}) : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  final Services services = Services();
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _cartItems();
  }

  void _cartItems() async {
    try {
      cartItems = await services.showCart();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve cart items: $e'),
        ),
      );
    }
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in cartItems) {
      double price = double.tryParse(item['Price'].toString()) ?? 0;
      int quantity = int.tryParse(item['Quantity'].toString()) ?? 0;

      print(
          "Item: ${item['Scientific_Name']}, Price: $price, Quantity: $quantity");

      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index]['Quantity'] = newQuantity.toString();
    });
  }

  void confirmOrder() async {
    if (cartItems.isNotEmpty) {
      double finalPrice = getTotalPrice();
      List<Map<String, dynamic>> quantityPrice = cartItems.map((item) {
        return {
          'Price': item['Price'].toString(),
          'Quantity': item['Quantity'].toString(),
        };
      }).toList();

      try {
        var response = await services.createOrder(finalPrice, quantityPrice);
        print('Order created: $response');
        setState(() => cartItems.clear());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order sent. ID: ${response['id']}")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Order failed: $e")),
        );
      }
    } else {
      print("Cart is empty");
    }
  }

  Future<void> deletetFromCart(int productId, int index) async {
    try {
      await services.deleteProductFromCart(productId);
      setState(() {
        cartItems.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item removed from cart")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item from cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = getTotalPrice();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppColors.primary,
            child: Align(
              alignment: Alignment(0, -0.83),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                     Text(
                      S.of(context).Cart,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only( topLeft: Radius.circular(60)),
              ),
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Container(
                        width: 380,
                        child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (context, i) {
                              double price = double.tryParse(
                                      cartItems[i]['Price'].toString()) ??
                                  0;

                              return Dismissible(
                                key: Key(cartItems[i]['id'].toString()),
                                background: Container(
                                  color: Colors.red,
                                  child:  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.delete, color: Colors.white),
                                        Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  if (cartItems[i].containsKey('id') &&
                                      cartItems[i]['id'] is int) {
                                    int productId = cartItems[i]['id'];
                                    deletetFromCart(productId, i);
                                  } else {
                                    print(
                                        "Error: Invalid or missing product ID for item at index $i: ${cartItems[i]}");
                                  }
                                },
                                child: Cartwidget(
                                  name: cartItems[i]['Scientific_Name'],
                                  //  image:
                                  //      "http://${Services().host}/${cartItems[i]['photo']}",
                                  price: price,
                                  onQuantityChange: (newQuantity) {
                                    updateQuantity(i, newQuantity);
                                  },
                                ),
                              );
                            }),
                      ),    
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0, left: isArabic() ?0 :10 , right: isArabic()?10:0),
                          child: Row(
                            children: [
                              Text(
                                '${S.of(context).TotalPrice}: $totalPrice SYP',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: confirmOrder,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              primary: AppColors.darkerGreen,
                              fixedSize: Size(270, 45),
                            ),
                            child: Text(
                              S.of(context).CheckOut,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
