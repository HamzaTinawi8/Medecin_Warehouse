import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/data/enums/search_type.dart';
import 'package:medecin_warehouse/data/model/category_search.dart';
import 'package:medecin_warehouse/data/model/medicine_search.dart';

class SearchResults extends StatelessWidget {
  final List<MedicineSearch> medicines;
  final List<CategorySearch> categories;
  final SearchType searchType;

  const SearchResults({
    required this.medicines,
    required this.categories,
    required this.searchType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchType == SearchType.medicine
          ? medicines.length
          : categories.length,
      itemBuilder: (context, index) {
        if (searchType == SearchType.medicine) {
          return _buildMedicineItem(medicines[index]);
        } else {
          return _buildCategoryItem(categories[index]);
        }
      },
    );
  }

  Widget _buildMedicineItem(MedicineSearch medicine) {
    return ListTile(
        hoverColor: AppColors.darkerGreen,
        title: Text(
          "ScientificName :${medicine.scientificName}",
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        subtitle: Text(
          "ComericalName : ${medicine.comercialName}",
          style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 0, 0, 0)),
        ),
        trailing: Text("Price : ${medicine.price}" ,style: TextStyle(fontSize: 10,)));
  }

  Widget _buildCategoryItem(CategorySearch category) {
    return ListTile(
      title: Row(
        children: [Text("${category.x} : "),
         
         Text(category.title)],
      ),
    );
  }
}
