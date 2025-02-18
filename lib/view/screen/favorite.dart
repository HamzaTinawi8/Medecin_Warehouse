import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/core/constant/linkAuth.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/screen/deatils_medicine.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Services services = Services();
  List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  void _fetchFavorites() async {
    try {
      favoriteItems = await services.showFavorite();
      print('Favorite Items: $favoriteItems');
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve cart items: $e'),
        ),
      );
    }
  }

  Future<void> deletetFromFavorites(int productId, int index) async {
    try {
      await Services().deletdProductFromFavourite(productId);
      setState(() {
        favoriteItems.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item removed from Favorites")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item from Favorites: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppColors.primary,
            child:  Align(
              alignment: Alignment(0, -0.83),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  S.of(context).MyFavorite,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: ListView.builder(
                        itemCount: favoriteItems.length,
                        itemBuilder: (context, index) {
                          var item = favoriteItems[index];

                          return Dismissible(
                            key: Key(item['product_id'].toString()),
                            background: Container(
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              if (favoriteItems[index]
                                      .containsKey('product_id') &&
                                  favoriteItems[index]['product_id'] is int) {
                                int productId =
                                    favoriteItems[index]['product_id'];
                                deletetFromFavorites(productId, index);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error: Cannot delete item without a valid product ID")),
                                );
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              elevation: 4,
                              child: ListTile(
                                leading: (item['photo'] != null)
                                    ? Image.network(
                                        "http://$host/${item['photo']}",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.error,
                                              size: 50);
                                        },
                                      )
                                    : const SizedBox(),
                                title: Text(
                                    item['Scientific_Name'] ?? 'Unknown',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                subtitle: Text('${S.of(context).Price}: ${item['Price']} SYP'),
                                onTap: () {
                                  if (item.containsKey('product_id') &&
                                      item['product_id'] is int) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsMedicineScreen(
                                                x: item['product_id']),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Details not available for this item'),
                                      ),
                                    );
                                  }
                                },
                                trailing: Text(S.of(context).Deatils,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                    
                   
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}