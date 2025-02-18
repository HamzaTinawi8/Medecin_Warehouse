import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/data/enums/search_type.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/view/screen/cart_screen.dart';
import 'package:medecin_warehouse/view/widget/search_bar_with_filtter.dart';
import 'package:intl/intl.dart';

class TopContainer extends StatelessWidget {
  final TextEditingController searchBarController;
  final Function onFilter;
  final SearchType searchType;

  const TopContainer({
    required this.searchBarController,
    required this.onFilter,
    required this.searchType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).tittle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey[350],
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Cartpage();
                      }));
                    },
                    icon: Icon(Icons.shopping_cart_outlined),
                    color: Colors.teal[300],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Container(
              alignment: isArabic()? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                S.of(context).subtittle,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            SearchBarWithFilter(
              controller: searchBarController,
              onFilter: onFilter,
              searchType: searchType,
            ),
          ],
        ),
      ),
    );
  }
}

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}
