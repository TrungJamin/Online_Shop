class Category {
  final String categoryName;
  final String categoryPath;
  // Tai sao nen co const o constructor
  const Category({required this.categoryName, required this.categoryPath});
  // ToJson
  // fromJson
  /*set category(String value) { // set cannot be used for final fields
    categoryName = value;
  }*/
}
