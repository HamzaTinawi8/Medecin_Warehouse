import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/widget/card_order.dart';

import '../../generated/l10n.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = Services();
    int inum = 0;

    return Scaffold(
      body: FutureBuilder<List>(
        future: services.getUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            String errorMessage = 'An error occurred';
            if (snapshot.error
                .toString()
                .contains('The expected orders key was not found')) {
              errorMessage = 'No orders were found in the server response.';
            } else if (snapshot.error
                .toString()
                .contains('Non-JSON response received')) {
              errorMessage = 'The server did not return a JSON response.';
            } else if (snapshot.error is HttpException) {
              errorMessage =
                  'The server encountered an error with status code: ${(snapshot.error as HttpException)}';
            } else {
              errorMessage = snapshot.error.toString();
            }
            return Center(child: Text(errorMessage));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No orders found"),
            );
          }

          List orders = snapshot.data!;
          print('Data received: ${snapshot.data}');
          return Stack(
            children: [
              Container(
                height: double.infinity,
                color: AppColors.primary,
                child:  Align(
                  alignment: Alignment(0, -0.83),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      S.of(context).MyOrders,
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
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60)),
                  ),
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      var order = orders[index];
                      inum++;
                      return Cardorder(
                        orderNumber: order['id'],
                        totalPrice:
                            double.parse(order['Final_Price'].toString()),
                        orderState: order['Status'],
                        priceState: order['Payment_Status'] == 0
                            ?  S.of(context).NotPaid
                            : S.of(context).Paid, // Example logic
                        orderDate: DateTime.parse(order['created_at']),
                        num: inum,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
