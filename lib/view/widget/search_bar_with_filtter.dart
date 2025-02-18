import 'package:flutter/material.dart';
import 'package:medecin_warehouse/data/enums/search_type.dart';
import 'package:medecin_warehouse/generated/l10n.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController 
  controller;
  final Function onFilter;
  final SearchType searchType;

  const SearchBarWithFilter(
    
      {required this.controller,
      required this.onFilter,
      required this.searchType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: S.of(context).hintsearch,
                suffixIcon: const Icon(Icons.mic),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => onFilter(),
          child: Text(
            searchType == SearchType.medicine ? S.of(context).medsearch : S.of(context).catsearch,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
