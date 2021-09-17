import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/screens/cart/cart.dart';
import 'package:online_shop_udemy/screens/wish_list/wish_list.dart';
import 'package:provider/provider.dart';

import 'components/feed_product.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = "/FeedsScreen";
  @override
  Widget build(BuildContext context) {
    print("Rebuild FeedsScreen!");

    List<Product> _products =
        Provider.of<ProductRepositoryImpl>(context).products;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Feeds",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          Consumer<WishListRepositoryImpl>(
            builder: (ctx, _, __) {
              final wishListProvider = Provider.of<WishListRepositoryImpl>(
                ctx,
              );
              return Badge(
                badgeColor: ColorsConsts.favBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                badgeContent: Text(
                  wishListProvider.getWishListItems.length.toString(),
                ),
                position: BadgePosition.topEnd(top: 4, end: 7),
                child: IconButton(
                  icon: wishListProvider.getWishListItems.length > 0
                      ? Icon(
                          MaterialCommunityIcons.heart,
                          color: Colors.red,
                        )
                      : Icon(
                          MyIcons.wishList,
                          color: ColorsConsts.favColor,
                        ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishList.routeName);
                  },
                ),
              );
            },
          ),
          Consumer<CartRepositoryImpl>(
            builder: (ctx, _, __) {
              final cartProvider = Provider.of<CartRepositoryImpl>(ctx);
              return Badge(
                badgeColor: ColorsConsts.cartBadgeColor,
                animationType: BadgeAnimationType.slide,
                toAnimate: true,
                badgeContent: Text(
                  cartProvider.getCartItems.length.toString(),
                ),
                position: BadgePosition.topEnd(top: 4, end: 7),
                child: IconButton(
                  icon: Icon(
                    MyIcons.cart,
                    color: ColorsConsts.cartColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: new StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(10),
          crossAxisCount: 6,
          itemCount: _products.length,
          itemBuilder: (BuildContext context, int index) => FeedProduct(
            product: _products[index],
          ),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(3, index.isEven ? 5 : 5),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 6.0,
        ),
      ),
    );

//      Scaffold(
//        body: GridView.count(
//      crossAxisCount: 2,
////    crossAxisCount: 3, -> cellWidth = parentWidth / 3
//      childAspectRatio: 240 / 290,
////    cellWidth = parentWidth / crossAxisCount & cellHeight = cellWidth / childAspectRatio
////    => childAspectRatio = cellHeight / cellWidth
//      crossAxisSpacing: 8,
//      mainAxisSpacing: 8,
//      children: List.generate(
//        100,
//        (index) => FeedProduct(),
//      ),
//    ));
  }
}
