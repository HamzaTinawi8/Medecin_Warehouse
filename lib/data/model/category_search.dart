class CategorySearch {
  final String x;
  final String title;
  

  const CategorySearch({
    required this.x,
    required this.title,
  });

  factory CategorySearch.fromJson(Map<String, dynamic> json) => CategorySearch(
        x: json['x'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'title': title,
      };
}
