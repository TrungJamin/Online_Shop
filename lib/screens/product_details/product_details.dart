import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/screens/cart/cart.dart';
import 'package:online_shop_udemy/screens/feeds/components/feed_product.dart';
import 'package:online_shop_udemy/screens/wish_list/wish_list.dart';
import 'package:online_shop_udemy/ultis/get_screen_size.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  final Product chosenProduct;

  const ProductDetails({Key? key, required this.chosenProduct})
      : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = GetScreenSize.getScreenSize(context);
    final wishListProvider =
        Provider.of<WishListRepositoryImpl>(context, listen: true);
    List<Product> _products =
        Provider.of<ProductRepositoryImpl>(context, listen: false).products;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartRepositoryImpl>(context);
    final isProductInCart =
        cartProvider.getCartItems.containsKey(widget.chosenProduct.id);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(color: Colors.black12),
            height: size.height * 0.45,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: widget.chosenProduct.imgUrl,
              placeholder: (context, url) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.save,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //padding: const EdgeInsets.all(16.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.9,
                              child: Text(
                                widget.chosenProduct.title,
                                maxLines: 2,
                                style: TextStyle(
                                  // color: Theme.of(context).textSelectionColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'US \$ ${widget.chosenProduct.price}',
                              style: TextStyle(
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21.0),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 3.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.chosenProduct.description,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 21.0,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          height: 1,
                        ),
                      ),
                      _details(themeState.darkTheme, 'Brand: ',
                          widget.chosenProduct.brand),
                      _details(themeState.darkTheme, 'Quantity: ',
                          '${widget.chosenProduct.quantity} Left'),
                      _details(themeState.darkTheme, 'Category: ',
                          widget.chosenProduct.productCategoryName),
                      _details(
                        themeState.darkTheme,
                        'Popularity: ',
                        widget.chosenProduct.isPopular
                            ? "Popular"
                            : "Barely Known",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),

                      // const SizedBox(height: 15.0),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 21.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                'Be the first review!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  height: 330,
                  child: ListView.builder(
                    itemCount: _products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return FeedProduct(
                        product: _products[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "DETAIL",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                ),
                actions: <Widget>[
                  Consumer<WishListRepositoryImpl>(
                    builder: (ctx, _, __) {
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
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                        ),
                      );
                    },
                  ),
                ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      onPressed: isProductInCart
                          ? null
                          : () {
                              cartProvider.addAProductToCart(
                                id: widget.chosenProduct.id,
                                title: widget.chosenProduct.title,
                                price: widget.chosenProduct.price,
                                quantity: 1,
                                imgUrl: widget.chosenProduct.imgUrl,
                              );
                            },
                      child: Text(
                        isProductInCart
                            ? "IN CART"
                            : 'Add to Cart'.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Buy now'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).textSelectionColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    height: 50,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: !wishListProvider.isProductInWishList(
                              id: widget.chosenProduct.id)
                          ? () {
                              wishListProvider.addAProductToWishList(
                                  id: widget.chosenProduct.id,
                                  title: widget.chosenProduct.title,
                                  price: widget.chosenProduct.price,
                                  imgUrl: widget.chosenProduct.imgUrl);
                            }
                          : () {
                              wishListProvider.removeProductFromWishList(
                                  id: widget.chosenProduct.id);
                            },
                      child: Center(
                        child: wishListProvider.isProductInWishList(
                                id: widget.chosenProduct.id)
                            ? Icon(
                                MaterialCommunityIcons.heart,
                                color: Colors.red,
                              )
                            : Icon(
                                MyIcons.wishList,
                                color: ColorsConsts.white,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontWeight: FontWeight.w600,
                fontSize: 21.0),
          ),
          Text(
            info,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20.0,
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
