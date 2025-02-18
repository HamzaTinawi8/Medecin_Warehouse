class MedicineSearch {
  final int id;
  final String comercialName;
  final String scientificName;
  final String price;

  const MedicineSearch({
    required this.id,
    required this.comercialName,
    required this.scientificName,
    required this.price
  });

  factory MedicineSearch.fromJson(Map<String, dynamic> json) {
    return MedicineSearch(
      id: json['id'],
      comercialName: json['Commercial_Name'],
      scientificName: json['Scientific_Name'],
      price: json['Price'],
    );
  }
}
