import 'package:flutter/material.dart';
import 'package:medecin_warehouse/generated/l10n.dart';
import 'package:medecin_warehouse/services/all_service.dart';
import 'package:medecin_warehouse/view/screen/categories_screen.dart';
import 'package:medecin_warehouse/view/widget/home/top_container.dart';

class AllCompanies extends StatefulWidget {
  const AllCompanies({super.key});

  @override
  State<AllCompanies> createState() => _AllCompaniesState();
}

class _AllCompaniesState extends State<AllCompanies> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding:  EdgeInsets.only(left: isArabic()?0 :20 , top: 10 , right: isArabic() ?20 : 0),
            alignment: isArabic()? Alignment.centerRight : Alignment.centerLeft,
          child:  Text(
            S.of(context).AllCompanies,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        FutureBuilder<List>(
          future: Services().getcompany(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: screenSize.height * 0.005,
                crossAxisSpacing: screenSize.width * 0.01,
                crossAxisCount: screenSize.width > 600 ? 3 : 2,
                children: List.generate(
                  snapshot.data!.length,
                  (i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CategoriesScreen(
                                  x: snapshot.data![i]['id'],
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 9,
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              (snapshot.data![i]['photo'] != null)
                                  ? Image.network(
                                      "http://${Services().host}/${snapshot.data![i]['photo']}",
                                      height: 100,
                                      width: 120,
                                    )
                                  : const SizedBox(),
                              Text(
                                "${snapshot.data![i]['Company_Name']}",
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
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
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
