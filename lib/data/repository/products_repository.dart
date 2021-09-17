import 'package:online_shop_udemy/data/models/product_model.dart';

abstract class ProductsRepository {
  List<Product> get products;
  List<Product> get getPopularProducts;
  List<Product>? getProductsByCategory(String categoryName);
  Iterable<Product>? getProductsByBrand(String brand);
  Product getProductById(String id);
}
