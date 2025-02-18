import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';


class deatils extends StatelessWidget {
  const deatils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return(
       
       FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: AppColors.darkerGreen,
                  label: Row(
                    children: const [Text('Deatils',style: TextStyle(fontSize: 15),), Icon(Icons.arrow_right,size: 30,)],
                  ),
                )
    );
  }
}