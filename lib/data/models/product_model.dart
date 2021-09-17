import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  final String productCategoryName;
  final String brand;
  final int quantity;
  final bool isFavorite;
  final bool isPopular;
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imgUrl,
      required this.productCategoryName,
      required this.brand,
      required this.quantity,
      this.isFavorite = false,
      this.isPopular = false});
}
