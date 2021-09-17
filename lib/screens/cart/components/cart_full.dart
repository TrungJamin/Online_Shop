import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/data/models/cart_model.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/products_repository_impl.dart';
import 'package:online_shop_udemy/screens/product_details/product_details.dart';
import 'package:online_shop_udemy/services/global_methods.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final Cart productInCart;

  const CartFull({Key? key, required this.productInCart}) : super(key: key);

  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductRepositoryImpl>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartProvider = Provider.of<CartRepositoryImpl>(context);
    return SafeArea(
      child: Container(
        height: 135,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Material(
              child: InkWell(
                onTap: () {
                  final productDetail =
                      productProvider.getProductById(widget.productInCart.id);
                  Navigator.pushNamed(context, ProductDetails.routeName,
                      arguments: productDetail);
                },
                child: CachedNetworkImage(
                  imageUrl: widget.productInCart.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
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
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              widget.productInCart.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              GlobalMethods.showConfirmDialog(
                                  'Remove item!',
                                  'Product will be removed from the cart!',
                                  () => cartProvider.removeProductFromCart(
                                      id: widget.productInCart.id),
                                  context);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Entypo.cross,
                                color: Colors.red,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Price:'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.productInCart.price}\$',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Sub Total:'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${(widget.productInCart.price * widget.productInCart.quantity).roundToDouble()}\$',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: themeChange.darkTheme
                                    ? Colors.brown.shade900
                                    : Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Ships Free',
                            style: TextStyle(
                                color: themeChange.darkTheme
                                    ? Colors.brown.shade900
                                    : Theme.of(context).accentColor),
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            // splashColor: ,
                            onTap: widget.productInCart.quantity < 2
                                ? null
                                : () {
                                    cartProvider.reduceNumberOfProductInCart(
                                        id: widget.productInCart.id);
                                  },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.minus,
                                  color: widget.productInCart.quantity < 2
                                      ? Colors.grey
                                      : Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 12,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ColorsConsts.gradiendLStart,
                                    ColorsConsts.gradiendLEnd,
                                  ],
                                  stops: [0.0, 0.7],
                                ),
                              ),
                              child: Text(
                                '${widget.productInCart.quantity}',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(30),
                            // splashColor: ,
                            onTap: () {
                              cartProvider.increaseNumberOfProductInCart(
                                  id: widget.productInCart.id);
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Entypo.plus,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
