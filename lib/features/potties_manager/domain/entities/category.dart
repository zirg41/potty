class Category {
  final String categoryName;
  int countOfUse;

  Category({
    required this.categoryName,
    required this.countOfUse,
  });

  void incrementCountOfUse() {
    countOfUse += 1;
  }
}
