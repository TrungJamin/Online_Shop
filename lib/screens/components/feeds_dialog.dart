import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({required this.productId});

  @override
  Widget build(BuildContext context) {
    final productsData =
        Provider.of<ProductRepositoryImpl>(context, listen: false);

    final cartProvider = Provider.of<CartRepositoryImpl>(context);

    final wishListProvider = Provider.of<WishListRepositoryImpl>(context);

    final prodAttr = productsData.getProductById(productId);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          CachedNetworkImage(
            imageUrl: prodAttr.imgUrl,
            imageBuilder: (context, imageProvider) => Container(
              constraints: BoxConstraints(
                  minHeight: 100,
                  maxHeight: MediaQuery.of(context).size.height * 0.5),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  image: DecorationImage(
                    image: imageProvider,
                  )),
            ),
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.error),
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(
                        context,
                        0,
                        () => {
                              wishListProvider.addAndRemoveProductFromWishList(
                                  id: prodAttr.id,
                                  title: prodAttr.title,
                                  price: prodAttr.price,
                                  imgUrl: prodAttr.imgUrl),
                            }),
                  ),
                  Flexible(
                    child: dialogContent(
                        context,
                        1,
                        () => {
                              Navigator.pushNamed(
                                      context, ProductDetails.routeName,
                                      arguments: prodAttr)
                                  .then((value) => Navigator.canPop(context)
                                      ? Navigator.pop(context)
                                      : null),
                            }),
                  ),
                  Flexible(
                    child: dialogContent(
                      context,
                      2,
                      cartProvider.getCartItems.containsKey(productId)
                          ? () {}
                          : () {
                              cartProvider.addAProductToCart(
                                  id: prodAttr.id,
                                  title: prodAttr.title,
                                  price: prodAttr.price,
                                  imgUrl: prodAttr.imgUrl);
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  // ignore: unnecessary_statements
                                  : null;
                            },
                    ),
                  ),
                ]),
          ),

          /************close****************/
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.3),
                shape: BoxShape.circle),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function fct) {
    final cart = Provider.of<CartRepositoryImpl>(context);
    final favs = Provider.of<WishListRepositoryImpl>(context);
    List<IconData> _dialogIcons = [
      favs.getWishListItems.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Feather.eye,
      MyIcons.cart,
    ];

    List<String> _texts = [
      favs.getWishListItems.containsKey(productId)
          ? 'In wishlist'
          : 'Add to wishlist',
      'View product',
      cart.getCartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color> _colors = [
      favs.getWishListItems.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
    ];
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              InkWell(
                onTap: () => fct(),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    _texts[index],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      //  fontSize: 15,
                      color: themeChange.darkTheme
                          ? Theme.of(context).disabledColor
                          : ColorsConsts.subTitle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
