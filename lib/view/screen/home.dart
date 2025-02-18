import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/data/data_source/category_search.dart';
import 'package:medecin_warehouse/data/enums/search_type.dart';
import 'package:medecin_warehouse/data/model/category_search.dart';
import 'package:medecin_warehouse/data/model/medicine_search.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/widget/home/all_companies.dart';
import 'package:medecin_warehouse/view/widget/home/top_container.dart';
import 'package:medecin_warehouse/view/widget/search_resulte.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MedicineSearch> filteredMedicines = [];
  List<CategorySearch> filteredCategories = [];
  SearchType _searchType = SearchType.medicine;

  @override
  void initState() {
    super.initState();
    // filteredMedicines = allMedicine;
    filteredCategories = allCategories;
    _searchController.addListener(_updateSearchResults);
  }

  void _updateSearchResults() {
    if (_searchType == SearchType.medicine) {
      filterMedicines();
    } else {
      filterCategories();
    }
  }

  void filterMedicines() async {
    if (_searchController.text.isNotEmpty)  {
      filteredMedicines =
          await Services().searchMedicine(query: _searchController.text);
    } else {}
    setState(() {});
  }

   void filterCategories() {
    if (_searchController.text.isEmpty) {
      filteredCategories = allCategories;
    } else {
      filteredCategories = allCategories
          .where((category) => category.title
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            TopContainer(
              searchBarController: _searchController,
              onFilter: _filterSearchType,
              searchType: _searchType,
            ),
            if (_searchController.text.isNotEmpty)
              SearchResults(
                medicines: filteredMedicines,
                categories: filteredCategories,
                searchType: _searchType,
              ),
            const AllCompanies(),
          ],
        ),
      ),
    );
  }

  void _filterSearchType() {
    setState(() {
      _searchType = _searchType == SearchType.medicine
          ? SearchType.category
          : SearchType.medicine;
      _updateSearchResults();
    });
  }
}
