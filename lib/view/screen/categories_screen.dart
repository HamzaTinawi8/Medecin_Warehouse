import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/services/authservie.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/screen/cart_screen.dart';
import 'package:medecin_warehouse/view/screen/login.dart';
import 'package:medecin_warehouse/view/screen/medicines_screen.dart';

class CategoriesScreen extends StatefulWidget {
  int x;
  CategoriesScreen({required this.x});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return (Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                  Text(
                    S.of(context).Categories,
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Cartpage();
                      }));
                    },
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110),
          child: Container(
            decoration: BoxDecoration(
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
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              S.of(context).AllCategories,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FutureBuilder<List>(
                              future: Services().getcategories(x: widget.x),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    mainAxisSpacing: screenSize.height * 0.005,
                                    crossAxisSpacing: screenSize.width * 0.01,
                                    crossAxisCount:
                                        screenSize.width > 600 ? 3 : 2,
                                    children: List.generate(
                                      snapshot.data!.length,
                                      (i) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return MedicinesScreen(
                                                    x: snapshot.data![i]['id']);
                                              }));
                                            },
                                            child: Card(
                                              elevation: 9,
                                              color: Colors.green[50],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 20),
                                                  (snapshot.data![i]['photo'] !=
                                                          null)
                                                      ? Image.network(
                                                          "http://${Services().host}/${snapshot.data![i]['photo']}",
                                                          height: 100,
                                                          width: 120,
                                                        )
                                                      : const SizedBox(),
                                                  Text(
                                                    "${snapshot.data![i]['Category_Name']}",
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return CircularProgressIndicator();
                              }),
                        ],
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    )));
  }
}
