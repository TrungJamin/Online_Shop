import 'package:flutter/cupertino.dart';
import 'package:online_shop_udemy/data/models/wish_list_model.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository.dart';

class WishListRepositoryImpl extends ChangeNotifier
    implements WishListRepository {
  Map<String, WishListItem> _wishListItems = {};
  @override
  Map<String, WishListItem> get getWishListItems => {..._wishListItems};

  @override
  void addAProductToWishList(
      {required String id,
      required String title,
      required double price,
      required String imgUrl}) {
    _wishListItems.putIfAbsent(id,
        () => WishListItem(id: id, title: title, price: price, imgUrl: imgUrl));
    notifyListeners();
  }

  @override
  void removeProductFromWishList({required String id}) {
    if (_wishListItems.containsKey(id)) {
      _wishListItems.remove(id);
    }
    notifyListeners();
  }

  @override
  void clearAllProductInWishList() {
    _wishListItems.clear();
    notifyListeners();
  }

  @override
  bool isProductInWishList({required String id}) {
    return _wishListItems.containsKey(id);
  }

  @override
  void addAndRemoveProductFromWishList(
      {required String id,
      required String title,
      required double price,
      required String imgUrl}) {
    if (isProductInWishList(id: id)) {
      removeProductFromWishList(id: id);
    } else {
      addAProductToWishList(id: id, title: title, price: price, imgUrl: imgUrl);
    }
  }
}
