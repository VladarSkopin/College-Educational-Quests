
class Category {
  final String categoryName;
  final String imgUrl;

  Category({
    required this.categoryName, required this.imgUrl
  });

  static List<Category> categories = [
    Category(
      categoryName: 'Загадки Петербурга',
      imgUrl: 'assets/images/riddles.jpg',
    ),
    Category(
      categoryName: 'Петербургские парки',
      imgUrl: 'assets/images/parks.jpg',
    ),
    Category(
      categoryName: 'Родной колледж',
      imgUrl: 'assets/images/college.png',
    ),
  ];
}

