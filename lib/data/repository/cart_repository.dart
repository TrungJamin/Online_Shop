import 'package:online_shop_udemy/data/models/cart_model.dart';

abstract class CartRepository {
  Map<String, Cart> get getCartItems;
  double get totalAmount;
  void addAProductToCart({
    required String id,
    required String title,
    required double price,
    required int quantity,
    String? imgUrl,
  });
  void increaseNumberOfProductInCart({required String id});
  void reduceNumberOfProductInCart({required String id});
  bool isProductInCart({required String id});
  void removeProductFromCart({required String id});
  void clearAllProductFromCart();
}
