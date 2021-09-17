import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/repository/cart_repository_impl.dart';
import 'package:online_shop_udemy/data/repository/wish_list_repository_impl.dart';
import 'package:online_shop_udemy/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

class PopularProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product productsAttributes = Provider.of<Product>(context);
    final cartProvider = Provider.of<CartRepositoryImpl>(context);
    bool isProductInCart =
        cartProvider.getCartItems.containsKey(productsAttributes.id);
    final wishListProvider = Provider.of<WishListRepositoryImpl>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              10.0,
            ),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProductDetails.routeName,
                  arguments: productsAttributes);
            },
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: 250,
                        child: CachedNetworkImage(
                          imageUrl: productsAttributes.imgUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 170,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110, vertical: 60),
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 10,
                        child: Icon(
                          Entypo.star,
                          color: wishListProvider.isProductInWishList(
                                  id: productsAttributes.id)
                              ? Colors.red
                              : Colors.grey.shade800,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 7,
                        child: Icon(
                          Entypo.star_outlined,
                          color: wishListProvider.isProductInWishList(
                                  id: productsAttributes.id)
                              ? Colors.transparent
                              : Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 12,
                        bottom: 32.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color: Theme.of(context).backgroundColor,
                          child: Text(
                            '\$ ${productsAttributes.price}',
                            style: TextStyle(
                              // ignore: deprecated_member_use
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productsAttributes.title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              productsAttributes.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: isProductInCart
                                ? null
                                : () {
                                    cartProvider.addAProductToCart(
                                      id: productsAttributes.id,
                                      title: productsAttributes.title,
                                      price: productsAttributes.price,
                                      imgUrl: productsAttributes.imgUrl,
                                    );
                                  },
                            borderRadius: BorderRadius.circular(30.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isProductInCart
                                    ? MaterialCommunityIcons.check_all
                                    : MaterialCommunityIcons.cart_plus,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
