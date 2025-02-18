import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/widget/card_deatils.dart';

import '../../generated/l10n.dart';

class DeatilsOrderScreen extends StatelessWidget {
  final int orderId;
  const DeatilsOrderScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final services = Services();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppColors.primary,
            child: Align(
              alignment: Alignment(0, -0.83),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
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
                        size: 30,
                      ),
                    ),
                    Text(
                      S.of(context).DeaitilsofOrder,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
              ),
              height: double.infinity,
              width: double.infinity,
              child: FutureBuilder<List>(
                future: services.getUserOrdersDetails(orderId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.hasData) {
                    List items = snapshot.data!;
                    print('Number of items: ${items.length}');
                    print('Items: $items');

                    if (items.isEmpty) {
                      return const Center(
                          child: Text("No details found for this order"));
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];
                        String name = item['Product_Name']
                         ?? 'No name provided';
                        double price = double.parse(item['Price']);

                        int quantity = item['Quantity'] ?? 1;
                        return CardDeatils(
                          name: name,
                          image: item['photo']
                           ?? 'default_image.png',
                          price: price,
                          quantity: quantity,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("No data available"));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
