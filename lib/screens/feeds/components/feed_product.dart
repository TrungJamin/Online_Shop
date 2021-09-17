import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/colors.dart';
import 'package:online_shop_udemy/data/models/product_model.dart';
import 'package:online_shop_udemy/data/provider/dark_theme_provider.dart';
import 'package:online_shop_udemy/screens/components/feeds_dialog.dart';
import 'package:online_shop_udemy/screens/product_details/product_details.dart';
import 'package:online_shop_udemy/ultis/get_screen_size.dart';
import 'package:provider/provider.dart';

class FeedProduct extends StatelessWidget {
  FeedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = GetScreenSize.getScreenSize(context);
    return Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
      final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: product),
          child: Container(
            height: 290,
            width: 250,
            color: darkThemeProvider.darkTheme
                ? ColorsConsts.saltBox
                : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                            minHeight: 100, maxHeight: size.height * 0.3),
                        child: CachedNetworkImage(
                          imageUrl: product.imgUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            margin: EdgeInsets.only(left: 5),
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Badge(
                      toAnimate: true,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8)),
                      badgeContent:
                          Text('New', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.description,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "\$ ${product.price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${product.quantity}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          InkWell(
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    FeedDialog(productId: product.id),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
