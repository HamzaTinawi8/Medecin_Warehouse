import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/view/widget/counter.dart';

class Cartwidget extends StatefulWidget {
  final String? name;
  final String? image;
  final double price;
  final Function(int) onQuantityChange;

  const Cartwidget({
    Key? key,
    this.name,
    this.image,
    required this.price,
    required this.onQuantityChange,
  }) : super(key: key);

  @override
  State<Cartwidget> createState() => _CartwidgetState();
}

class _CartwidgetState extends State<Cartwidget> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.price * quantity;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                 image: 
                DecorationImage(
                   fit: BoxFit.cover,
                   image: widget.image != null
                       ? NetworkImage(widget.image!)
                       :  const AssetImage('assets/images/im.jpg')
                          as ImageProvider,
                 ),
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name ?? 'Unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Price: ${widget.price.toStringAsFixed(2)} SYP',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Total: $totalPrice SYP',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.darkerGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),

            Column(
              children: [
                Counter(
                  initialValue: quantity,
                  onCounterChanged: (newQuantity) {
                    setState(() {
                      quantity = newQuantity;
                      totalPrice = widget.price * newQuantity;
                    });
                    widget.onQuantityChange(newQuantity);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}









