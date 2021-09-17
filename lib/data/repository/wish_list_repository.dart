import 'package:online_shop_udemy/data/models/wish_list_model.dart';

abstract class WishListRepository {
  Map<String, WishListItem> get getWishListItems;
  void addAProductToWishList({
    required String id,
    required String title,
    required double price,
    required String imgUrl,
  });
  bool isProductInWishList({required String id});
  void removeProductFromWishList({required String id});
  void addAndRemoveProductFromWishList(
      {required String id,
      required String title,
      required double price,
      required String imgUrl});
  void clearAllProductInWishList();
}
