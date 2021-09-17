import 'package:flutter/cupertino.dart';
import 'package:online_shop_udemy/data/models/cart_model.dart';

import 'cart_repository.dart';

class CartRepositoryImpl extends ChangeNotifier implements CartRepository {
  Map<String, Cart> _cartItems = {};
  @override
  // TODO: implement getCartItems
  Map<String, Cart> get getCartItems => _cartItems;

  @override
  // TODO: implement totalAmount
  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total.roundToDouble();
  }

  @override
  void addAProductToCart(
      {required String id,
      required String title,
      required double price,
      int quantity = 1,
      String? imgUrl}) {
    // TODO: implement addAProductToCart
    try {
      _cartItems.putIfAbsent(
          id,
          () => Cart(
              id: id,
              title: title,
              quantity: quantity,
              price: price,
              imgUrl: imgUrl!));
    } catch (err) {
      throw err;
    }
    notifyListeners();
  }

  @override
  void reduceNumberOfProductInCart({required String id}) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(id, (existingProduct) {
        Cart updatedProduct =
            existingProduct.copyWith(quantity: existingProduct.quantity - 1);
        return updatedProduct;
      });
    }
    notifyListeners();
  }

  @override
  void increaseNumberOfProductInCart({required String id}) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(id, (existingProduct) {
        Cart updatedProduct =
            existingProduct.copyWith(quantity: existingProduct.quantity + 1);
        return updatedProduct;
      });
    }
    notifyListeners();
  }

  @override
  bool isProductInCart({required String id}) {
    return _cartItems.containsKey(id);
  }

  @override
  void clearAllProductFromCart() {
    _cartItems.clear();
    notifyListeners();
  }

  @override
  void removeProductFromCart({required String id}) {
    if (_cartItems.containsKey(id)) {
      _cartItems.remove(id);
    }
    notifyListeners();
  }
}
