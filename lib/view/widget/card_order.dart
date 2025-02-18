import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/view/screen/deatils_order.dart';

class Cardorder extends StatelessWidget {
  final int orderNumber;
  final int num;
  final double totalPrice;
  final String orderState;
  final String priceState;
  final DateTime orderDate;

  const Cardorder({
    Key? key,
    required this.orderNumber,
    required this.num,
    required this.totalPrice,
    required this.orderState,
    required this.priceState,
    required this.orderDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${orderDate.day}/${orderDate.month}/${orderDate.year}";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeatilsOrderScreen(orderId: orderNumber),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Text(
                        "Order $num",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkerGreen,
                        ),
                      ),
                      Text('${S.of(context).Total}: ${totalPrice.toStringAsFixed(2)} SYP'),
                      Text('${S.of(context).OrderState}: $orderState'),
                      Text('${S.of(context).PaymentState}: $priceState'),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        color: AppColors.darkGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.darkerGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
